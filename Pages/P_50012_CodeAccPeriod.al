page 50012 "Code Type"
{
    PageType = List;
    Caption = 'Code Type';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CodeType_AccountingPeriod;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("S.No."; Rec."S.No.")
                {
                    ApplicationArea = All;


                }
                field("Dimension Financial Year"; Rec."Dimension Financial Year")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}