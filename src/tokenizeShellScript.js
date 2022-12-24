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
const RE_ANYTHING_SHORT = /^\S+/
const RE_ANYTHING = /^.+/s
const RE_ANYTHING_UNTIL_CLOSE_BRACE = /^[^\}]+/
const RE_QUOTE_DOUBLE = /^"/
const RE_QUOTE_SINGLE = /^'/
const RE_QUOTE_BACKTICK = /^`/
const RE_STRING_DOUBLE_QUOTE_CONTENT = /^[^"]+/
const RE_STRING_SINGLE_QUOTE_CONTENT = /^[^']+/
const RE_STRING_BACKTICK_QUOTE_CONTENT = /^[^`]+/
const RE_KEYWORD =
  /^(?:alias|bg|bind|break|builtin|caller|case|cd|command|compgen|complete|continue|dirs|disown|do|done|echo|elif|else|enable|esac|eval|exec|exit|false|fc|fg|fi|for|getopts|hash|help|history|if|in|jobs|kill|let|logout|popd|printf|pushd|pwd|read|readonly|set|shift|shopt|source|suspend|test|then|times|trap|true|type|ulimit|umask|unalias|unset|wait|while)\b/

const RE_VARIABLE_NAME = /^[a-zA-Z\_\/\-\$][a-zA-Z\_\/\-\$#\d]*/
const RE_PUNCTUATION = /^[:,;\{\}\[\]\.=\(\)<>\!\|\+\&\>\)]/
const RE_NUMERIC = /^\d+(?=\s|$)/
const RE_FUNCTION_NAME = /^\w+(?=\s*\()/
const RE_EOF_START = /^<<\s*EOF/
const RE_EOF_END = /^EOF/
const RE_EOF_CONTENT = /.*/s

export const initialLineState = {
  state: State.TopLevelContent,
  tokens: [],
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
  while (index < line.length) {
    const part = line.slice(index)
    switch (state) {
      case State.TopLevelContent:
        if ((next = part.match(RE_WHITESPACE))) {
          token = TokenType.Whitespace
          state = State.TopLevelContent
        } else if ((next = part.match(RE_KEYWORD))) {
          switch (next[0]) {
            case 'if':
            case 'do':
            case 'continue':
            case 'for':
            case 'else':
            case 'fi':
            case 'esac':
            case 'case':
            case 'done':
            case 'in':
            case 'then':
            case 'elif':
            case 'break':
            case 'while':
              token = TokenType.KeywordControl
              break
            case 'exit':
            case 'set':
            case 'unset':
            case 'echo':
            case 'shift':
            case 'command':
            case 'test':
            case 'exec':
            case 'getopts':
              token = TokenType.Function
              break
            case 'true':
            case 'false':
              token = TokenType.LanguageConstant
              break
            default:
              token = TokenType.Keyword
              break
          }
          state = State.TopLevelContent
        } else if ((next = part.match(RE_EOF_START))) {
          token = TokenType.Punctuation
          state = State.InsideEof
        } else if ((next = part.match(RE_PUNCTUATION))) {
          token = TokenType.Punctuation
          state = State.TopLevelContent
        } else if ((next = part.match(RE_FUNCTION_NAME))) {
          token = TokenType.Function
          state = State.TopLevelContent
        } else if ((next = part.match(RE_VARIABLE_NAME))) {
          token = TokenType.VariableName
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
          token = TokenType.Text
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
        if ((next = part.match(RE_EOF_END))) {
          token = TokenType.Punctuation
          state = State.TopLevelContent
        } else if ((next = part.match(RE_EOF_CONTENT))) {
          token = TokenType.String
          state = State.InsideEof
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
  }
}
