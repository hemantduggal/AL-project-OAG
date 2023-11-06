tableextension 50025 GLAccBudgetBuffer extends "G/L Acc. Budget Buffer"
{
    fields
    {
        field(50000; "Budget Dimension 5 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(5);
            Caption = 'Budget Dimension 5 Filter';
            FieldClass = FlowFilter;
        }
        field(50001; "Budget Dimension 6 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(6);
            Caption = 'Budget Dimension 6 Filter';
            FieldClass = FlowFilter;
        }
        field(50002; "Budget Dimension 7 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(7);
            Caption = 'Budget Dimension 7 Filter';
            FieldClass = FlowFilter;
        }
        field(50003; "Budget Dimension 8 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(8);
            Caption = 'Budget Dimension 8 Filter';
            FieldClass = FlowFilter;
        }
    }
}