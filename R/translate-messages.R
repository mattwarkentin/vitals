translate_to_messages <- function(chat) {
  turns <- chat$get_turns(include_system_prompt = TRUE)
  model <- chat$get_model()
  purrr::map(turns, translate_to_message, model = model)
}

translate_to_message <- function(turn, model) {
  role <- turn@role
  source <- if (role == "user") "input" else "generate"

  message <- list(id = generate_id())

  if (role == "system") {
    message$content <- turn@text
    message$role <- role
    return(message)
  } else if (role == "user") {
    if (
      length(turn@contents) == 1 &&
        inherits(turn@contents[[1]], "ellmer::ContentToolResult")
    ) {
      tool_result <- turn@contents[[1]]
      message$content <- collapse_tool_result(tool_result)
      message$tool_call_id <- tool_result@request@id
      message$`function` <- tool_result@request@name
      return(message)
    } else {
      message$content <- turn@text
      message$source <- source
    }
  } else {
    message$content <- list(list(type = "text", text = turn@text))
    message$source <- source

    tool_requests <- purrr::keep(turn@contents, function(content) {
      inherits(content, "ellmer::ContentToolRequest")
    })

    if (length(tool_requests) > 0) {
      tool_calls <- lapply(tool_requests, function(req) {
        list(
          id = req@id,
          `function` = req@name,
          arguments = req@arguments
        )
      })

      message$tool_calls <- tool_calls
      message$model <- model
    }
  }

  message$role <- role

  message
}

collapse_tool_result <- function(tool_result) {
  if (!is.null(tool_result@error)) {
    return(as.character(tool_result@error))
  }

  contents <- purrr::map_chr(tool_result@value, tool_result_value_to_string)
  paste0(contents, collapse = "\n")
}

tool_result_value_to_string <- function(x) {
  if (is.atomic(x)) {
    return(paste0(x, collapse = "\n"))
  }

  switch(
    x$type,
    text = x$text,
    image = paste0("[image:", x$source$media_type, "] ",
                   "data:", x$source$media_type, ";base64,", x$source$data),
    audio = paste0("[audio:", x$source$media_type, "] ",
                   "data:", x$source$media_type, ";base64,", x$source$data),
    video = paste0("[video:", x$source$media_type, "] ",
                   "data:", x$source$media_type, ";base64,", x$source$data),
    input_string(tibble::as_tibble(x$source))
  )
}
