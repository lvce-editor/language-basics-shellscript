case "$a" in
  *" -> "*)
    a=`echo "$a" | sed -n -e "$a"`
    case "$a" in
      /* | ?:/* | ?:\\*) a="$a" ;;
      *) a=`echo "$a" | sed -e "$a"`/"$a" ;;
    esac ;;
  *) break ;;
esac