import {
  initialLineState,
  tokenizeLine,
  TokenType,
  TokenMap,
} from '../src/tokenizeShellScript.js'

const DEBUG = true

const expectTokenize = (text, state = initialLineState.state) => {
  const lineState = {
    stack: [],
    state,
  }
  const tokens = []
  const lines = text.split('\n')
  for (let i = 0; i < lines.length; i++) {
    const result = tokenizeLine(lines[i], lineState)
    lineState.state = result.state
    tokens.push(...result.tokens.map((token) => token.type))
    tokens.push(TokenType.NewLine)
  }
  tokens.pop()
  return {
    toEqual(...expectedTokens) {
      if (DEBUG) {
        expect(tokens.map((token) => TokenMap[token])).toEqual(
          expectedTokens.map((token) => TokenMap[token])
        )
      } else {
        expect(tokens).toEqual(expectedTokens)
      }
    },
  }
}

test('empty', () => {
  expectTokenize('').toEqual()
})

test('whitespace', () => {
  expectTokenize(' ').toEqual(TokenType.Whitespace)
})

test('keyword', () => {
  // see https://github.com/microsoft/vscode/blob/main/extensions/shellscript/syntaxes/shell-unix-bash.tmLanguage.json#L1268
  expectTokenize('alias').toEqual(TokenType.Keyword)
  expectTokenize('bg').toEqual(TokenType.Keyword)
  expectTokenize('bind').toEqual(TokenType.Keyword)
  expectTokenize('break').toEqual(TokenType.Keyword)
  expectTokenize('builtin').toEqual(TokenType.Keyword)
  expectTokenize('caller').toEqual(TokenType.Keyword)
  expectTokenize('cd').toEqual(TokenType.Keyword)
  expectTokenize('command').toEqual(TokenType.Keyword)
  expectTokenize('compgen').toEqual(TokenType.Keyword)
  expectTokenize('complete').toEqual(TokenType.Keyword)
  expectTokenize('dirs').toEqual(TokenType.Keyword)
  expectTokenize('disown').toEqual(TokenType.Keyword)
  expectTokenize('echo').toEqual(TokenType.Keyword)
  expectTokenize('enable').toEqual(TokenType.Keyword)
  expectTokenize('eval').toEqual(TokenType.Keyword)
  expectTokenize('exec').toEqual(TokenType.Keyword)
  expectTokenize('exit').toEqual(TokenType.Keyword)
  expectTokenize('false').toEqual(TokenType.Keyword)
  expectTokenize('fc').toEqual(TokenType.Keyword)
  expectTokenize('fg').toEqual(TokenType.Keyword)
  expectTokenize('getopts').toEqual(TokenType.Keyword)
  expectTokenize('hash').toEqual(TokenType.Keyword)
  expectTokenize('help').toEqual(TokenType.Keyword)
  expectTokenize('history').toEqual(TokenType.Keyword)
  expectTokenize('jobs').toEqual(TokenType.Keyword)
  expectTokenize('kill').toEqual(TokenType.Keyword)
  expectTokenize('let').toEqual(TokenType.Keyword)
  expectTokenize('logout').toEqual(TokenType.Keyword)
  expectTokenize('popd').toEqual(TokenType.Keyword)
  expectTokenize('printf').toEqual(TokenType.Keyword)
  expectTokenize('pushd').toEqual(TokenType.Keyword)
  expectTokenize('pwd').toEqual(TokenType.Keyword)
  expectTokenize('read').toEqual(TokenType.Keyword)
  expectTokenize('readonly').toEqual(TokenType.Keyword)
  expectTokenize('set').toEqual(TokenType.Keyword)
  expectTokenize('shift').toEqual(TokenType.Keyword)
  expectTokenize('shopt').toEqual(TokenType.Keyword)
  expectTokenize('source').toEqual(TokenType.Keyword)
  expectTokenize('suspend').toEqual(TokenType.Keyword)
  expectTokenize('test').toEqual(TokenType.Keyword)
  expectTokenize('times').toEqual(TokenType.Keyword)
  expectTokenize('trap').toEqual(TokenType.Keyword)
  expectTokenize('true').toEqual(TokenType.Keyword)
  expectTokenize('type').toEqual(TokenType.Keyword)
  expectTokenize('ulimit').toEqual(TokenType.Keyword)
  expectTokenize('unalias').toEqual(TokenType.Keyword)
  expectTokenize('unset').toEqual(TokenType.Keyword)
  expectTokenize('wait').toEqual(TokenType.Keyword)
})
