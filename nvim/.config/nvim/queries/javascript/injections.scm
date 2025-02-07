;; styled.div`<css>`
;(call_expression
; function: (member_expression
;   object: (identifier) @_name
;     (#eq? @_name "styled"))
; arguments: ((template_string) @styled
;  (#offset! @styled 0 1 0 -1)))
;
;
;(call_expression
;  function: (identifier) @function_name (#eq? @function_name "createGlobalStyle")
;  arguments: ((template_string) @css
;  (#offset! @css 0 1 0 -1))
;)

(call_expression
  function: (identifier) @function_name (#eq? @function_name "createGlobalStyle")
  arguments: ((template_string) @injection.content)
    (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "css")
)
