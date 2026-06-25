find "`dirname $file`" -name "$base"'*'

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (string
      (command_substitution
        (command
          (command_name
            (word))
          (simple_expansion
            (variable_name)))))
    (word)
    (concatenation
      (string
        (simple_expansion
          (variable_name)))
      (raw_string))))


echo "\"The great escape\`\${var}"

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (string
      (string_content))))


echo "s/$/'/"
echo "#"
echo "s$"

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (string
      (string_content)
      (string_content)))
  (command
    (command_name
      (word))
    (string
      (string_content)))
  (command
    (command_name
      (word))
    (string
      (string_content))))


echo $'Here\'s Johnny!\r\n'

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (ansi_c_string)))


a=()
b=(1 2 3)

echo ${a[@]}
echo ${#b[@]}

a[$i]=50
a+=(foo "bar" $(baz))

printf "  %-9s" "${seq0:-(default)}"

--------------------------------------------------------------------------------

(program
  (variable_assignment
    (variable_name)
    (array))
  (variable_assignment
    (variable_name)
    (array
      (number)
      (number)
      (number)))
  (command
    (command_name
      (word))
    (expansion
      (subscript
        (variable_name)
        (word))))
  (command
    (command_name
      (word))
    (expansion
      (subscript
        (variable_name)
        (word))))
  (variable_assignment
    (subscript
      (variable_name)
      (simple_expansion
        (variable_name)))
    (number))
  (variable_assignment
    (variable_name)
    (array
      (word)
      (string
        (string_content))
      (command_substitution
        (command
          (command_name
            (word))))))
  (command
    (command_name
      (word))
    (string
      (string_content))
    (string
      (expansion
        (variable_name)
        (array
          (word))))))


echo -ne "\033k$1\033\\" > /dev/stderr

--------------------------------------------------------------------------------

(program
  (redirected_statement
    (command
      (command_name
        (word))
      (word)
      (string
        (string_content)
        (simple_expansion
          (variable_name))
        (string_content)))
    (file_redirect
      (word))))


curl -# localhost #comment without space
nix build nixpkgs#hello -v # comment with space

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (word)
    (word))
  (comment)
  (command
    (command_name
      (word))
    (word)
    (word)
    (word))
  (comment))


echo 'word'#not-comment # a legit comment
echo $(uname -a)#not-comment # a legit comment
echo `uname -a`#not-comment # a legit comment
echo $hey#not-comment # a legit comment
var=#not-comment # a legit comment
echo "'$var'" # -> '#not-comment'

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (concatenation
      (raw_string)
      (word)))
  (comment)
  (command
    (command_name
      (word))
    (concatenation
      (command_substitution
        (command
          (command_name
            (word))
          (word)))
      (word)))
  (comment)
  (command
    (command_name
      (word))
    (concatenation
      (command_substitution
        (command
          (command_name
            (word))
          (word)))
      (word)))
  (comment)
  (command
    (command_name
      (word))
    (concatenation
      (simple_expansion
        (variable_name))
      (word)))
  (comment)
  (variable_assignment
    (variable_name)
    (word))
  (comment)
  (command
    (command_name
      (word))
    (string
      (string_content)
      (simple_expansion
        (variable_name))
      (string_content)))
  (comment))


loop=; variables=& here=;;

--------------------------------------------------------------------------------

(program
  (variable_assignment
    (variable_name))
  (variable_assignment
    (variable_name))
  (variable_assignment
    (variable_name)))


component_type="${1}" item_name="${2?}"

--------------------------------------------------------------------------------

(program
  (variable_assignments
    (variable_assignment
      (variable_name)
      (string
        (expansion
          (variable_name))))
    (variable_assignment
      (variable_name)
      (string
        (expansion
          (variable_name))))))


echo $((1 + 2 - 3 * 4 / 5))
a=$((6 % 7 ** 8 << 9 >> 10 & 11 | 12 ^ 13))
$(((${1:-${SECONDS}} % 12) + 144))
((foo=0))
echo $((bar=1))
echo $((-1, 1))
echo $((! -a || ~ +b || ++c || --d))
echo $((foo-- || bar++))
(("${MULTIBUILD_VARIANTS}" > 1))
$(("$(stat --printf '%05a' "${save_file}")" & 07177))
soft_errors_count=$[soft_errors_count + 1]

--------------------------------------------------------------------------------

(program
  (command
    (command_name
      (word))
    (arithmetic_expansion
      (binary_expression
        (binary_expression
          (number)
          (number))
        (binary_expression
          (binary_expression
            (number)
            (number))
          (number)))))
  (variable_assignment
    (variable_name)
    (arithmetic_expansion
      (binary_expression
        (binary_expression
          (binary_expression
            (binary_expression
              (binary_expression
                (number)
                (binary_expression
                  (number)
                  (number)))
              (number))
            (number))
          (number))
        (binary_expression
          (number)
          (number)))))
  (command
    (command_name
      (arithmetic_expansion
        (binary_expression
          (parenthesized_expression
            (binary_expression
              (expansion
                (variable_name)
                (expansion
                  (variable_name)))
              (number)))
          (number)))))
  (compound_statement
    (binary_expression
      (variable_name)
      (number)))
  (command
    (command_name
      (word))
    (arithmetic_expansion
      (binary_expression
        (variable_name)
        (number))))
  (command
    (command_name
      (word))
    (arithmetic_expansion
      (unary_expression
        (number))
      (number)))
  (command
    (command_name
      (word))
    (arithmetic_expansion
      (binary_expression
        (binary_expression
          (binary_expression
            (unary_expression
              (unary_expression
                (variable_name)))
            (unary_expression
              (unary_expression
                (variable_name))))
          (unary_expression
            (variable_name)))
        (unary_expression
          (variable_name)))))
  (command
    (command_name
      (word))
    (arithmetic_expansion
      (binary_expression
        (postfix_expression
          (variable_name))
        (postfix_expression
          (variable_name)))))
  (compound_statement
    (binary_expression
      (string
        (expansion
          (variable_name)))
      (number)))
  (command
    (command_name
      (arithmetic_expansion
        (binary_expression
          (string
            (command_substitution
              (command
                (command_name
                  (word))
                (word)
                (raw_string)
                (string
                  (expansion
                    (variable_name))))))
          (number)))))
  (variable_assignment
    (variable_name)
    (arithmetic_expansion
      (binary_expression
        (variable_name)
        (number)))))


main() {
    local foo="asd"`
        `"fgh"
}

