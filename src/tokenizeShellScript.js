/**
 * @enum number
 */
export const State = {
  TopLevelContent: 1,
  InsideDoubleQuoteString: 2,
  InsideLineComment: 3,
  InsideSingleQuoteString: 4,
  InsideBackTickString: 5,
  InsideEof: 6,
  AfterKeywordFunction: 7,
}

export const StateMap = {
  [State.TopLevelContent]: 'TopLevelContent',
}

/**
 * @enum number
 */
export const TokenType = {
  None: 1,
  Whitespace: 2,
  PunctuationString: 3,
  String: 4,
  Keyword: 5,
  Numeric: 6,
  Punctuation: 7,
  VariableName: 8,
  Comment: 885,
  Text: 9,
  KeywordControl: 10,
  Function: 11,
  LanguageConstant: 12,
  KeywordReturn: 13,
}

export const TokenMap = {
  [TokenType.None]: 'None',
  [TokenType.Whitespace]: 'Whitespace',
  [TokenType.PunctuationString]: 'PunctuationString',
  [TokenType.String]: 'String',
  [TokenType.Keyword]: 'Keyword',
  [TokenType.Numeric]: 'Numeric',
  [TokenType.Punctuation]: 'Punctuation',
  [TokenType.VariableName]: 'VariableName',
  [TokenType.Comment]: 'Comment',
  [TokenType.Text]: 'Text',
  [TokenType.KeywordControl]: 'KeywordControl',
  [TokenType.Function]: 'Function',
  [TokenType.LanguageConstant]: 'LanguageConstant',
  [TokenType.KeywordReturn]: 'KeywordReturn',
}

const RE_LINE_COMMENT = /^#.*/s
const RE_SELECTOR = /^[\.a-zA-Z\d\-\:>]+/
const RE_WHITESPACE = /^\s+/
const RE_CURLY_OPEN = /^\{/
const RE_CURLY_CLOSE = /^\}/
const RE_PROPERTY_NAME = /^[a-zA-Z\-]+\b/
const RE_COLON = /^:/
const RE_PROPERTY_VALUE = /^[^;\}]+/
const RE_SEMICOLON = /^;/
const RE_COMMA = /^,/
const RE_ANYTHING_SHORT = /^[^\s"']+/
const RE_ANYTHING = /^.+/s
const RE_ANYTHING_UNTIL_CLOSE_BRACE = /^[^\}]+/
const RE_QUOTE_DOUBLE = /^"/
const RE_QUOTE_SINGLE = /^'/
const RE_QUOTE_BACKTICK = /^`/
const RE_STRING_DOUBLE_QUOTE_CONTENT = /^[^"\\]+/
const RE_STRING_SINGLE_QUOTE_CONTENT = /^[^']+/
const RE_STRING_BACKTICK_QUOTE_CONTENT = /^[^`]+/
const RE_KEYWORD =
  /^(?:7za|7zr|alias|ar|awk|bg|bind|break|builtin|bunzip|bunzip2|caller|case|cargo|cat|catdog|cd|cp|command|compgen|complete|continue|curl|dirs|disown|dpkg|do|done|echo|elif|else|emulate|enable|esac|eval|eval_gettext|exec|exit|false|fc|fg|fi|for|function|getopts|grep|grub-mount|gzip|hash|head|help|history|identity|if|in|jobs|kill|let|lha|less|logout|lunzip|lzip|lzma|mkdir|mktemp|miniunz|miniunzip|mv|npm|node|pdftotext|popd|printf|pushd|pwd|rar|read|readonly|rm|rpm|sed|set|shift|shopt|sleep|snap|source|suspend|return|tar|tee|test|then|times|trap|true|type|ulimit|umask|unalias|unarj|unmkinitramfs|unrar|unset|unwrapdiff|unzip|unzoo|xz|wait|which|while|zoo|zstd|umask)\b/
const RE_VARIABLE_NAME = /^[a-zA-Z\_\/\-\$][a-zA-Z\_\/\-\$#\d\-]*/
const RE_PUNCTUATION = /^[:,;\{\}\[\]\.=\(\)<>\!\|\+\&\>\)]/
const RE_NUMERIC = /^\d+(?=\s|$)/
const RE_FUNCTION_NAME = /^\w+(?=\s*\()/
const RE_EOF_START = /^<<\s*(\w+)/
const RE_EOF_CONTENT = /.*/s
const RE_STRING_ESCAPE = /^\\./
const RE_BACKSLASH_AT_END = /^\\$/

export const initialLineState = {
  state: State.TopLevelContent,
  tokens: [],
  knownFunctionNames: new Set(),
  stringEnd: '',
}

/**
 *
 * @param {any} lineStateA
 * @param {any} lineStateB
 * @returns
 */
export const isEqualLineState = (lineStateA, lineStateB) => {
  return lineStateA.state === lineStateB.state
}

export const hasArrayReturn = true

/**
 * @param {string} line
 * @param {any} lineState
 */
export const tokenizeLine = (line, lineState) => {
  let next = null
  let index = 0
  let tokens = []
  let token = TokenType.None
  let state = lineState.state
  let stringEnd = lineState.stringEnd
  const knownFunctionNames = new Set(lineState.knownFunctionNames)
  while (index < line.length) {
    const part = line.slice(index)
    switch (state) {
      case State.TopLevelContent:
        if ((next = part.match(RE_WHITESPACE))) {
          token = TokenType.Whitespace
          state = State.TopLevelContent
        } else if ((next = part.match(RE_KEYWORD))) {
          state = State.TopLevelContent
          switch (next[0]) {
            case 'break':
            case 'case':
            case 'continue':
            case 'do':
            case 'done':
            case 'elif':
            case 'else':
            case 'esac':
            case 'fi':
            case 'for':
            case 'if':
            case 'in':
            case 'then':
            case 'while':
              token = TokenType.KeywordControl
              break
            case '7za':
            case '7zr':
            case 'alias':
            case 'ar':
            case 'awk':
            case 'bunzip':
            case 'bunzip2':
            case 'cargo':
            case 'cat':
            case 'catdoc':
            case 'cd':
            case 'command':
            case 'compgen':
            case 'complete':
            case 'cp':
            case 'curl':
            case 'disown':
            case 'dpkg':
            case 'echo':
            case 'emulate':
            case 'eval_gettext':
            case 'eval':
            case 'exec':
            case 'exit':
            case 'getopts':
            case 'grep':
            case 'grub-mount':
            case 'gzip':
            case 'head':
            case 'identity':
            case 'less':
            case 'lha':
            case 'ls':
            case 'lunzip':
            case 'lzip':
            case 'lzma':
            case 'miniunz':
            case 'miniunzip':
            case 'mkdir':
            case 'mktemp':
            case 'mv':
            case 'node':
            case 'npm':
            case 'pdftotext':
            case 'printf':
            case 'pushd':
            case 'pwd':
            case 'rar':
            case 'read':
            case 'rm':
            case 'rpm':
            case 'sed':
            case 'set':
            case 'shift':
            case 'shopt':
            case 'sleep':
            case 'snap':
            case 'source':
            case 'tar':
            case 'tee':
            case 'test':
            case 'trap':
            case 'type':
            case 'umask':
            case 'unarj':
            case 'unmkinitramfs':
            case 'unrar':
            case 'unset':
            case 'unwrapdiff':
            case 'unzip':
            case 'unzoo':
            case 'which':
            case 'xz':
            case 'zoo':
            case 'zstd':
              token = TokenType.Function
              break
            case 'true':
            case 'false':
              token = TokenType.LanguageConstant
              break
            case 'return':
              token = TokenType.KeywordReturn
              break
            case 'function':
              token = TokenType.Keyword
              state = State.AfterKeywordFunction
              break
            default:
              token = TokenType.Keyword
              break
          }
        } else if ((next = part.match(RE_EOF_START))) {
          token = TokenType.Punctuation
          state = State.InsideEof
          stringEnd = next[1]
        } else if ((next = part.match(RE_PUNCTUATION))) {
          token = TokenType.Punctuation
          state = State.TopLevelContent
        } else if ((next = part.match(RE_FUNCTION_NAME))) {
          token = TokenType.Function
          state = State.TopLevelContent
          knownFunctionNames.add(next[0])
        } else if ((next = part.match(RE_VARIABLE_NAME))) {
          if (knownFunctionNames.has(next[0])) {
            token = TokenType.Function
          } else {
            token = TokenType.VariableName
          }
          state = State.TopLevelContent
        } else if ((next = part.match(RE_NUMERIC))) {
          token = TokenType.Numeric
          state = State.TopLevelContent
        } else if ((next = part.match(RE_QUOTE_DOUBLE))) {
          token = TokenType.PunctuationString
          state = State.InsideDoubleQuoteString
        } else if ((next = part.match(RE_QUOTE_SINGLE))) {
          token = TokenType.Punctuation
          state = State.InsideSingleQuoteString
        } else if ((next = part.match(RE_QUOTE_BACKTICK))) {
          token = TokenType.Punctuation
          state = State.InsideBackTickString
        } else if ((next = part.match(RE_LINE_COMMENT))) {
          token = TokenType.Comment
          state = State.TopLevelContent
        } else if ((next = part.match(RE_ANYTHING_SHORT))) {
          token = TokenType.VariableName
          state = State.TopLevelContent
        } else if ((next = part.match(RE_ANYTHING))) {
          token = TokenType.Text
          state = State.TopLevelContent
        } else {
          part //?
          throw new Error('no')
        }
        break
      case State.InsideDoubleQuoteString:
        if ((next = part.match(RE_QUOTE_DOUBLE))) {
          token = TokenType.PunctuationString
          state = State.TopLevelContent
        } else if ((next = part.match(RE_STRING_DOUBLE_QUOTE_CONTENT))) {
          token = TokenType.String
          state = State.InsideDoubleQuoteString
        } else if ((next = part.match(RE_STRING_ESCAPE))) {
          token = TokenType.String
          state = State.InsideDoubleQuoteString
        } else if ((next = part.match(RE_BACKSLASH_AT_END))) {
          token = TokenType.String
          state = State.InsideDoubleQuoteString
        } else {
          throw new Error('no')
        }
        break
      case State.InsideSingleQuoteString:
        if ((next = part.match(RE_QUOTE_SINGLE))) {
          token = TokenType.PunctuationString
          state = State.TopLevelContent
        } else if ((next = part.match(RE_STRING_SINGLE_QUOTE_CONTENT))) {
          token = TokenType.String
          state = State.InsideSingleQuoteString
        } else if ((next = part.match(RE_BACKSLASH_AT_END))) {
          token = TokenType.String
          state = State.InsideSingleQuoteString
        } else {
          throw new Error('no')
        }
        break
      case State.InsideBackTickString:
        if ((next = part.match(RE_QUOTE_BACKTICK))) {
          token = TokenType.PunctuationString
          state = State.TopLevelContent
        } else if ((next = part.match(RE_STRING_BACKTICK_QUOTE_CONTENT))) {
          token = TokenType.String
          state = State.InsideBackTickString
        } else {
          throw new Error('no')
        }
        break
      case State.InsideEof:
        if ((next = part.match(stringEnd))) {
          token = TokenType.Punctuation
          state = State.TopLevelContent
        } else if ((next = part.match(RE_EOF_CONTENT))) {
          token = TokenType.String
          state = State.InsideEof
        } else {
          throw new Error('no')
        }
        break
      case State.AfterKeywordFunction:
        if ((next = part.match(RE_VARIABLE_NAME))) {
          token = TokenType.Function
          state = State.TopLevelContent
          knownFunctionNames.add(next[0])
        } else if ((next = part.match(RE_WHITESPACE))) {
          token = TokenType.Whitespace
          state = State.AfterKeywordFunction
        } else if ((next = part.match(RE_ANYTHING))) {
          token = TokenType.Text
          state = State.TopLevelContent
        } else {
          throw new Error('no')
        }
        break
      default:
        throw new Error('no')
    }
    const tokenLength = next[0].length
    index += tokenLength
    tokens.push(token, tokenLength)
  }
  return {
    state,
    tokens,
    knownFunctionNames,
    stringEnd,
  }
}
