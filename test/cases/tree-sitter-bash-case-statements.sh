case "opt" in
  a)
    echo a
    ;;

  b)
    echo b
    ;&

  c)
    echo c;;
esac

case "opt" in
  (a)
    echo a
    ;;

  (b)
    echo b
    ;&

  (c)
    echo c;;
esac

case "$Z" in
  ab*|cd*) ef
esac

case $dest in
  *.[1357])
    exit $?
    ;;
esac

case x in x) echo meow ;; esac

case foo in
  bar\ baz) : ;;
esac

case "$arg" in
  *([0-9])([0-9])) echo "$arg"
esac

case ${lang} in
CMakeLists.txt | \
	cmake_modules | \
	${PN}.pot) ;;
*) rm -r ${lang} || die ;;
esac

--------------------------------------------------------------------------------

(program
  (case_statement
    (string
      (string_content))
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word)))
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word)))
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word))))
  (case_statement
    (string
      (string_content))
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word)))
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word)))
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word))))
  (case_statement
    (string
      (simple_expansion
        (variable_name)))
    (case_item
      (extglob_pattern)
      (extglob_pattern)
      (command
        (command_name
          (word)))))
  (case_statement
    (simple_expansion
      (variable_name))
    (case_item
      (concatenation
        (word)
        (word)
        (number)
        (word))
      (command
        (command_name
          (word))
        (simple_expansion
          (special_variable_name)))))
  (case_statement
    (word)
    (case_item
      (word)
      (command
        (command_name
          (word))
        (word))))
  (case_statement
    (word)
    (case_item
      (word)
      (command
        (command_name
          (word)))))
  (case_statement
    (string
      (simple_expansion
        (variable_name)))
    (case_item
      (extglob_pattern)
      (command
        (command_name
          (word))
        (string
          (simple_expansion
            (variable_name))))))
  (case_statement
    (expansion
      (variable_name))
    (case_item
      (word)
      (word)
      (concatenation
        (expansion
          (variable_name))
        (word)))
    (case_item
      (extglob_pattern)
      (list
        (command
          (command_name
            (word))
          (word)
          (expansion
            (variable_name)))
        (command
          (command_name
            (word)))))))


if [[ "$lsb_dist" != 'Ubuntu' || $(ver_to_int "$lsb_release") < $(ver_to_int '14.04') ]]; then
	return 1
fi

[[ ${PV} != $(sed -n -e 's/^Version: //p' "${ED}/usr/$(get_libdir)/pkgconfig/tss2-tcti-tabrmd.pc" || die) ]]

[[ ${f} != */@(default).vim ]]

[[ "${MY_LOCALES}" != *en_US* || a != 2 ]]

[[ $(LC_ALL=C $(tc-getCC) ${LDFLAGS} -Wl,--version 2>/dev/null) != @(LLD|GNU\ ld)* ]]

[[ -f "${EROOT}/usr/share/php/.packagexml/${MY_P}.xml" && \
	-x "${EROOT}/usr/bin/peardev" ]]

[[ ${test} == @($(IFS='|'; echo "${skip[*]}")) ]]

[[ ${SRC_URI} == */${a}* ]]

[[ a == *_@(LIB|SYMLINK) ]]

[[ ${1} =~ \.(lisp|lsp|cl)$ ]]

[[ a == - ]]

--------------------------------------------------------------------------------

(program
  (if_statement
    (test_command
      (binary_expression
        (binary_expression
          (string
            (simple_expansion
              (variable_name)))
          (raw_string))
        (binary_expression
          (command_substitution
            (command
              (command_name
                (word))
              (string
                (simple_expansion
                  (variable_name)))))
          (command_substitution
            (command
              (command_name
                (word))
              (raw_string))))))
    (command
      (command_name
        (word))
      (number)))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (command_substitution
        (list
          (command
            (command_name
              (word))
            (word)
            (word)
            (raw_string)
            (string
              (expansion
                (variable_name))
              (string_content)
              (command_substitution
                (command
                  (command_name
                    (word))))
              (string_content)))
          (command
            (command_name
              (word)))))))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (binary_expression
        (string
          (expansion
            (variable_name)))
        (extglob_pattern))
      (binary_expression
        (word)
        (number))))
  (test_command
    (binary_expression
      (command_substitution
        (redirected_statement
          (command
            (variable_assignment
              (variable_name)
              (word))
            (command_name
              (command_substitution
                (command
                  (command_name
                    (word)))))
            (expansion
              (variable_name))
            (word))
          (file_redirect
            (file_descriptor)
            (word))))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (unary_expression
        (test_operator)
        (string
          (expansion
            (variable_name))
          (string_content)
          (expansion
            (variable_name))
          (string_content)))
      (unary_expression
        (test_operator)
        (string
          (expansion
            (variable_name))
          (string_content)))))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (extglob_pattern)
      (command_substitution
        (variable_assignment
          (variable_name)
          (raw_string))
        (command
          (command_name
            (word))
          (string
            (expansion
              (subscript
                (variable_name)
                (word))))))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (extglob_pattern)
      (expansion
        (variable_name))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (word)
      (extglob_pattern)))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (regex)))
  (test_command
    (binary_expression
      (word)
      (extglob_pattern))))


if (( 1 < 2 ? 1 : 2 )); then
	return 1
fi

--------------------------------------------------------------------------------

(program
  (if_statement
    (compound_statement
      (ternary_expression
        (binary_expression
          (number)
          (number))
        (number)
        (number)))
    (command
      (command_name
        (word))
      (number))))


$((n < 10 ? n : 10))
$(($n < 10 ? $n : 10))
$((${n} < 10 ? ${n} : 10))

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (arithmetic_expansion
        (ternary_expression
          (binary_expression
            (variable_name)
            (number))
          (variable_name)
          (number)))))
  (command
    (command_name
      (arithmetic_expansion
        (ternary_expression
          (binary_expression
            (simple_expansion
              (variable_name))
            (number))
          (simple_expansion
            (variable_name))
          (number)))))
  (command
    (command_name
      (arithmetic_expansion
        (ternary_expression
          (binary_expression
            (expansion
              (variable_name))
            (number))
          (expansion
            (variable_name))
          (number))))))


[[ "35d8b" =~ ^[0-9a-fA-F] ]]
[[ $CMD =~ (^|;)update_terminal_cwd($|;) ]]
[[ ! " ${completions[*]} " =~ " $alias_cmd " ]]
! [[ "$a" =~ ^a|b\ *c|d$ ]]
[[ "$1" =~ ^${var}${var}*=..* ]]
[[ "$1" =~ ^\-${var}+ ]]
[[ ${var1} == *${var2}* ]]
[[ "$server" =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]
[[ "$primary_wins" =~ ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) ]]
[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]]
[[ ${PV} =~ 99999999$ ]]
[[ $1 == -- ]]
[[ " ${REPLACING_VERSIONS} " != *\ ${PVR}\ * ]]
[[ ${file} == @(*${GENTOO_PATCH_NAME}.tar.xz|*.asc|*.sig) ]]
[[ $RUBY_TARGETS != *$( eselect ruby show | awk 'NR==2' | tr  -d ' '  )* ]]
[[ " ${m[0]##*/}" =~ ^(\ ${skip_files[*]/%/.*|\\} ) ]]
[[ ' boop xyz' =~ ' boop '(.*)$ ]]
[[ $b = foo* ]]

--------------------------------------------------------------------------------

(program
  (test_command
    (binary_expression
      (string
        (string_content))
      (regex)))
  (test_command
    (binary_expression
      (simple_expansion
        (variable_name))
      (regex)))
  (test_command
    (binary_expression
      (unary_expression
        (string
          (expansion
            (subscript
              (variable_name)
              (word)))))
      (string
        (simple_expansion
          (variable_name)))))
  (negated_command
    (test_command
      (binary_expression
        (string
          (simple_expansion
            (variable_name)))
        (regex))))
  (test_command
    (binary_expression
      (string
        (simple_expansion
          (variable_name)))
      (regex)))
  (test_command
    (binary_expression
      (string
        (simple_expansion
          (variable_name)))
      (regex)))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (extglob_pattern)
      (expansion
        (variable_name))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (string
        (simple_expansion
          (variable_name)))
      (regex)))
  (test_command
    (binary_expression
      (string
        (simple_expansion
          (variable_name)))
      (regex)))
  (test_command
    (binary_expression
      (unary_expression
        (test_operator)
        (expansion
          (variable_name)))
      (binary_expression
        (command_substitution
          (command
            (command_name
              (word))
            (word)
            (word)
            (word)
            (number)
            (string
              (expansion
                (variable_name)))))
        (extglob_pattern)
        (string
          (string_content))
        (extglob_pattern))))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (regex)))
  (test_command
    (binary_expression
      (simple_expansion
        (variable_name))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (string
        (expansion
          (variable_name)))
      (extglob_pattern)
      (expansion
        (variable_name))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (expansion
        (variable_name))
      (extglob_pattern)
      (expansion
        (variable_name))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (simple_expansion
        (variable_name))
      (extglob_pattern)
      (command_substitution
        (pipeline
          (command
            (command_name
              (word))
            (word)
            (word))
          (command
            (command_name
              (word))
            (raw_string))
          (command
            (command_name
              (word))
            (word)
            (raw_string))))
      (extglob_pattern)))
  (test_command
    (binary_expression
      (string
        (expansion
          (subscript
            (variable_name)
            (number))
          (regex)))
      (regex)))
  (test_command
    (binary_expression
      (raw_string)
      (regex)))
  (test_command
    (binary_expression
      (simple_expansion
        (variable_name))
      (regex))))


[[ ${test} == @($(IFS='|'; echo "${skip[*]}")) ]]

case ${out} in
*"not supported"*|\
*"operation not supported"*)
	;;
esac

case $1 in
-o)
	owner=$2
	shift
	;;
-g) ;;
esac

[[ a == \"+(?)\" ]]

