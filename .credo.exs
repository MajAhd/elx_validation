# This file contains the configuration for Credo and you are probably reading

%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "web/", "apps/"],
        excluded: [~r"/_build/", ~r"/deps/"]
      },
      plugins: [],
      requires: [],
      strict: false,
      parse_timeout: 5000,
      color: true,
      checks: [
        {Credo.Check.Consistency.ExceptionNames},
        {Credo.Check.Consistency.LineEndings},
        {Credo.Check.Consistency.ParameterPatternMatching},
        {Credo.Check.Consistency.SpaceAroundOperators},
        {Credo.Check.Consistency.SpaceInParentheses},
        {Credo.Check.Consistency.TabsOrSpaces},
        # For some checks, like AliasUsage, you can only customize the priority
        {Credo.Check.Design.AliasUsage, priority: :low},

        {Credo.Check.Design.DuplicatedCode, excluded_macros: []},
        {Credo.Check.Design.TagTODO, exit_status: 2},
        {Credo.Check.Design.TagFIXME},

        {Credo.Check.Readability.FunctionNames},
        {Credo.Check.Readability.LargeNumbers, false},
        {Credo.Check.Readability.MaxLineLength, false},
        {Credo.Check.Readability.ModuleAttributeNames},
        {Credo.Check.Readability.ModuleDoc},
        {Credo.Check.Readability.ModuleNames},
        {Credo.Check.Readability.ParenthesesOnZeroArityDefs},
        {Credo.Check.Readability.ParenthesesInCondition},
        {Credo.Check.Readability.PredicateFunctionNames},
        {Credo.Check.Readability.PreferImplicitTry},
        {Credo.Check.Readability.RedundantBlankLines},
        {Credo.Check.Readability.StringSigils},
        {Credo.Check.Readability.TrailingBlankLine},
        {Credo.Check.Readability.TrailingWhiteSpace},
        {Credo.Check.Readability.VariableNames},
        {Credo.Check.Readability.Semicolons},
        {Credo.Check.Readability.SpaceAfterCommas},
        {Credo.Check.Refactor.CondStatements},
        {Credo.Check.Refactor.CyclomaticComplexity, max_complexity: 50},
        {Credo.Check.Refactor.DoubleBooleanNegation},
        {Credo.Check.Refactor.FunctionArity},
        {Credo.Check.Refactor.LongQuoteBlocks},
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Refactor.MatchInCondition},
        {Credo.Check.Refactor.NegatedConditionsInUnless},
        {Credo.Check.Refactor.NegatedConditionsWithElse},
        {Credo.Check.Refactor.Nesting, max_nesting: 3},
        {Credo.Check.Refactor.PipeChainStart, false},
        {Credo.Check.Refactor.UnlessWithElse},

        {Credo.Check.Warning.BoolOperationOnSameValues},
        {Credo.Check.Warning.IExPry},
        {Credo.Check.Warning.IoInspect},
        {Credo.Check.Warning.LazyLogging, false},
        {Credo.Check.Warning.OperationOnSameValues},
        {Credo.Check.Warning.OperationWithConstantResult},
        {Credo.Check.Warning.UnusedEnumOperation},
        {Credo.Check.Warning.UnusedFileOperation},
        {Credo.Check.Warning.UnusedKeywordOperation},
        {Credo.Check.Warning.UnusedListOperation},
        {Credo.Check.Warning.UnusedPathOperation},
        {Credo.Check.Warning.UnusedRegexOperation},
        {Credo.Check.Warning.UnusedStringOperation},
        {Credo.Check.Warning.UnusedTupleOperation},
        {Credo.Check.Warning.RaiseInsideRescue},
        # Controversial and experimental checks (opt-in, just remove `, false`)
        {Credo.Check.Refactor.ABCSize, false},
        {Credo.Check.Refactor.AppendSingleItem, false},
        {Credo.Check.Refactor.VariableRebinding, false},
        {Credo.Check.Warning.MapGetUnsafePass, false},
        {Credo.Check.Consistency.MultiAliasImportRequireUse, false},
        # Deprecated checks (these will be deleted after a grace period)
        {Credo.Check.Readability.Specs, false},

      ]
    }
  ]
}
