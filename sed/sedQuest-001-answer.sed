1{
i\
<!DOCTYPE html>\
<html>\
<head>\
<meta charset="UTF-8">\
<title>
a\
<\/title>\
<\/head>
}

1!{
	/^Related Topics: /{
		N
                s/ \([aA-zZ0-9][^,:]*\),/ <b>\1<\/b>,/g
		s/ \([aA-zZ0-9][^,:]*\)$/ <b>\1<\/b>/g
	}
	/Read more: /{
        	s/http:\/\/.*/<a href=\"&\">&<\/a>/
	}
	s/^\(..*\)$/\1\
<br \/>/g
}

$a\
<\/body\>\
<\/html\>

