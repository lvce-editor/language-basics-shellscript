import { readFile, writeFile } from 'node:fs/promises'
import path, { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = dirname(fileURLToPath(import.meta.url))
const root = path.join(__dirname, '..')

const toAbsolutePath = (relativePath) => {
  const absolutePath = join(root, relativePath)
  return absolutePath
}

const readLines = async (relativePath) => {
  const absolutePath = toAbsolutePath(relativePath)
  const content = await readFile(absolutePath, 'utf8')
  const lines = content.split('\n')
  return lines
}

const isKeywordLine = (line) => {
  return line.startsWith('const RE_KEYWORD =')
}

const toSorted = (array) => {
  const sorted = array.slice().sort()
  for (let i = 0; i < sorted.length - 1; i++) {
    const a = sorted[i]
    const b = sorted[i + 1]
    if (b.startsWith(a) && b.includes('-')) {
      ;[sorted[i], sorted[i + 1]] = [sorted[i + 1], sorted[i]]
    }
  }
  return sorted
}

const escapeRegex = (regex) => {
  return regex.replaceAll('+', '\\+')
}

const getRegexLine = (lines) => {
  const allLinesSorted = toSorted(lines).map(escapeRegex)
  return `  /^(?:${allLinesSorted.join('|')})\\b/`
}

const isFunctionsStartIndex = (line, index) => {
  return line.trim() === "case 'while':"
}

const isFunctionsEndIndex = (line) => {
  return line.trim() === `case 'true':`
}

const getCaseLineFunction = (lineFunction) => {
  return `            case '${lineFunction}':`
}

const getCaseLinesFunctions = (linesFunctions) => {
  return linesFunctions.map(getCaseLineFunction)
}

const getNewLinesJs = (linesJs, linesExtra, linesFunctions) => {
  const keywordLine = linesJs.findIndex(isKeywordLine)
  if (keywordLine === -1) {
    throw new Error('keyword line not found')
  }
  const allLines = [...linesExtra, ...linesFunctions]
  const regexLine = getRegexLine(allLines)
  const functionStartIndex = linesJs.findIndex(isFunctionsStartIndex)
  if (functionStartIndex === -1) {
    throw new Error('function start index not found')
  }
  const functionEndIndex = linesJs.findIndex(isFunctionsEndIndex)
  if (functionEndIndex === -1) {
    throw new Error('function end index not found')
  }
  const caseLinesFunctions = getCaseLinesFunctions(linesFunctions)
  const linesToken = [
    `              token = TokenType.Function`,
    '              break',
  ]
  const newLinesJs = [
    ...linesJs.slice(0, keywordLine + 1),
    regexLine,
    ...linesJs.slice(keywordLine + 2, functionStartIndex + 4),
    ...caseLinesFunctions,
    ...linesToken,
    ...linesJs.slice(functionEndIndex),
  ]
  return newLinesJs
}

const writeLines = async (relativePath, lines) => {
  const absolutePath = toAbsolutePath(relativePath)
  const content = lines.join('\n')
  await writeFile(absolutePath, content)
}

const main = async () => {
  const linesExtra = await readLines('scripts/bash_extra_keywords.txt')
  const linesFunctions = await readLines('scripts/bash_functions.txt')
  const linesJs = await readLines('src/tokenizeShellScript.js')
  const newLinesJs = getNewLinesJs(linesJs, linesExtra, linesFunctions)
  await writeLines('src/tokenizeShellScript.js', newLinesJs)
}

main()
