import fs, { readFile, writeFile } from 'node:fs/promises'
import { copyFiles, packageExtension } from '@lvce-editor/package-extension'
import path, { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const extraKeywords = [
  'true',
  'false',
  'return',
  'function',
  'break',
  'case',
  'continue',
  'do',
  'done',
  'elif',
  'else',
  'esac',
  'fi',
  'for',
  'if',
  'in',
  'then',
  'while',
]

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
  return array.slice().sort()
}

const getRegexLine = (lines) => {
  const allLinesSorted = toSorted(lines)
  return `  /^(?:${allLinesSorted.join('|')})\b/`
}

const isFunctionsStartIndex = (line, index) => {
  console.log({ line: line.trim() })
  return line.trim() === "case 'while':" + 2
}

const isFunctionsEndIndex = (line) => {
  return line.trim() === `case 'true':`
}

const getCaseLineFunction = (lineFunction) => {
  return `        case '${lineFunction}':`
}

const getCaseLinesFunctions = (linesFunctions) => {
  return linesFunctions.map(getCaseLineFunction)
}

const getNewLinesJs = (linesJs, linesControl, linesFunctions) => {
  const keywordLine = linesJs.findIndex(isKeywordLine)
  if (keywordLine === -1) {
    throw new Error('keyword line not found')
  }
  const allLines = [...linesControl, ...linesFunctions, ...extraKeywords]
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
  const newLinesJs = [
    ...linesJs.slice(0, keywordLine + 1),
    regexLine,
    ...linesJs.slice(keywordLine + 2, functionStartIndex),
    ...caseLinesFunctions,
    ...linesJs.slice(functionEndIndex, functionStartIndex),
  ]
  return newLinesJs
}

const writeLines = async (relativePath, lines) => {
  const absolutePath = toAbsolutePath(relativePath)
  const content = lines.join('\n')
  await writeFile(absolutePath, content)
}

const main = async () => {
  const linesControl = await readLines('scripts/bash_control_keywords.txt')
  const linesFunctions = await readLines('scripts/bash_functions.txt')
  const linesJs = await readLines('src/tokenizeShellScript.js')
  const newLinesJs = getNewLinesJs(linesJs, linesControl, linesFunctions)
  await writeLines('src/tokenizeShellScript2.js', newLinesJs)
}

main()
