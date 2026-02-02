" Vim syntax file
" Language: Sequencer Language (DAMIC-M CCD Module)
" Maintainer: Generated for sequencer configuration files
" Latest Revision: 2026-02-02

if exists("b:current_syntax")
  finish
endif

" Comments
syn match sequencerComment "#.*$"

" Section headers
syn match sequencerSection "\[\w\+\]"

" Keywords in subroutines and mains
syn keyword sequencerKeyword CALL JSR RTS END repeat infinity

" Pointer keywords
syn keyword sequencerPointerType PTR_FUNC PTR_SUBR REP_FUNC REP_SUBR contained

" Special identifiers
syn match sequencerPointer "PTR_FUNC\s\+\w\+" contains=sequencerPointerType
syn match sequencerPointer "PTR_SUBR\s\+\w\+" contains=sequencerPointerType
syn match sequencerPointer "REP_FUNC\s\+\w\+" contains=sequencerPointerType
syn match sequencerPointer "REP_SUBR\s\+\w\+" contains=sequencerPointerType

" Constants (all caps identifiers followed by colon)
syn match sequencerConstant "^\s*[A-Z][A-Z0-9_]*:" contains=sequencerConstantName
syn match sequencerConstantName "^[A-Z][A-Z0-9_]*" contained

" Function names (identifiers followed by colon at start of line in functions section)
syn match sequencerFunction "^\s*\w\+:" contains=sequencerFunctionName
syn match sequencerFunctionName "^\w\+" contained

" Clock names (uppercase abbreviations)
syn match sequencerClock "\<\(RD\|RU\|V[123][ABC]\|TG[AB]\|H[123][ABC]\|SW[12]\|OG[12]\|RG[12]\|DG[12]\|TR[12]\)\>"

" Numbers
syn match sequencerNumber "\<\d\+\>"
syn match sequencerNumber "\<\d\+\.\d\+\>"

" Time units
syn keyword sequencerTimeUnit us ns ms

" Operators
syn match sequencerOperator "[:=,@]"

" String values (for things like "clocks:", "slices:", "constants:")
syn keyword sequencerLabel clocks slices constants

" Special values
syn keyword sequencerBoolean True False

" Parentheses and brackets
syn match sequencerDelimiter "[\[\]()]"

" @ symbol for pointer references
syn match sequencerPointerRef "@\w\+"

" Define highlighting colors
hi def link sequencerComment        Comment
hi def link sequencerSection        Title
hi def link sequencerKeyword        Keyword
hi def link sequencerPointerType    Type
hi def link sequencerConstantName   Constant
hi def link sequencerFunctionName   Function
hi def link sequencerClock          Identifier
hi def link sequencerNumber         Number
hi def link sequencerTimeUnit       Type
hi def link sequencerOperator       Operator
hi def link sequencerLabel          Label
hi def link sequencerBoolean        Boolean
hi def link sequencerDelimiter      Delimiter
hi def link sequencerPointerRef     Special

let b:current_syntax = "sequencer"
