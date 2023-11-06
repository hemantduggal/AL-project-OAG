pageextension 50100 GLBudEntries extends "G/L Budget Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Budget Type"; Rec."Budget Type")
            {
                ApplicationArea = All;
            }
            field("Budget Status"; Rec."Budget Status")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addafter("Ent&ry")
        {
            group("Import Data")
            {
                action(ImportLines)
                {
                    ApplicationArea = All;
                    Caption = 'Import Lines';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // RunObject = xmlport "WO ImportData";

                    trigger OnAction()
                    var

                        ImportworkOrderLines: XmlPort "Import Budget Entries";
                    begin
                        Clear(ImportworkOrderLines);
                        ImportworkOrderLines.Run();

                    end;
                }
            }
        }
    }
}