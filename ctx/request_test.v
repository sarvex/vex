module ctx

fn test_parse_form_body_urlencoded() {
	req := Req{
		body: 'foo=bar&lol=edgy'
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		}
	}
	body := req.parse_form_body() or {
		assert false
		return
	}
	assert body.len == 2
	assert body['foo'] == 'bar'
	assert body['lol'] == 'edgy'
}

fn test_parse_form_body_json() {
	req := Req{
		body: '{"bar":"baz"}'
		headers: {
			'Content-Type': 'application/json'
		}
	}
	body := req.parse_form_body() or {
		assert false
		return
	}
	assert body.len == 1
	assert body['bar'] == 'baz'
}

fn test_parse_form_body_content_type_not_present() {
	req := Req{
		body: '{"test":"123"}'
	}
	_ := req.parse_form_body() or {
		assert err == 'body content-type header not present'
		return
	}
	assert false
}

fn test_parse_form_body_invalid() {
	req := Req{
		body: 'text content'
		headers: {
			'Content-Type': 'text/plain'
		}
	}
	_ := req.parse_form_body() or {
		assert err == 'no appropriate content-type header for body found'
		return
	}
	assert false
}

fn test_parse_form_body_empty() {
	req := Req{}
	_ := req.parse_form_body() or {
		assert err == 'empty body'
		return
	}
	assert false
}

fn test_parse_cookies() {
	req := Req{
		headers: {
			'Cookie': 'foo=bar; randomstring=sdasd9as0d90a'
		}
	}
	cookies := req.parse_cookies() or {
		assert false
		return
	}
	assert cookies.len == 2
	assert cookies['foo'] == 'bar'
	assert cookies['randomstring'] == 'sdasd9as0d90a'
}

fn test_parse_cookies_empty() {
	req := Req{}
	cookies := req.parse_cookies() or {
		assert err == 'cookies not found'
		return
	}
	assert false
}
