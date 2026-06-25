cat <<EOF > file.txt
body
EOF

cat <<EOF | grep body
body
EOF

cat <<-EOF
	indented body
 EOF
	still body
	EOF

cat <<'EOF'
$literal
EOF

cat <<"EOF"
"literal"
EOF

cat <<-'EOF'
	tabbed
	EOF

cat <<!EOF!
punctuation delimiter
!EOF!

read -r value <<'=cut' | echo done
body
=cut

cat <<A <<-B
body a
A
	body b
	B

cat <<EOF
EOF 
EOF

read value <<<"$input"

value=$((left << right))

cat <<EOF
unterminated
