page 50023 "WHT Revenue Types"
{
    ApplicationArea = Basic, Suite;
    Caption = 'WHT Revenue Types';
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = 50009;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies code for the Revenue Type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description for the WHT Revenue Type.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the integer to group the Revenue Types.';
                }
            }
        }
    }

    actions
    {
    }
}

