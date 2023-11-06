page 50036 activesession
{
    ApplicationArea = all;
    Caption = 'Active session';
    Editable = false;
    Permissions = tabledata "Active Session" = rmd;
    DeleteAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Active Session";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Server Instance ID"; Rec."Server Instance ID")
                {
                    ApplicationArea = all;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = all;
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ApplicationArea = all;
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = all;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Delete)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.Delete();
                end;
            }
        }
    }
}