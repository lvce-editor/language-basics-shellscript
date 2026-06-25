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

