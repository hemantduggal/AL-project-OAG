page 50016 DimensionValues_API
{
    Caption = 'Dimension Values_API';
    DataCaptionFields = "Dimension Code";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Dimension Value";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = all;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;

                }
                field("Dimension Value Type"; Rec."Dimension Value Type")
                {
                    ApplicationArea = all;

                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = all;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Map-to IC Dimension Value Code"; Rec."Map-to IC Dimension Value Code")
                {
                    ApplicationArea = all;

                }
                field("Consolidation Code"; Rec."Consolidation Code")
                {
                    ApplicationArea = all;

                }
            }
        }

        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

}

