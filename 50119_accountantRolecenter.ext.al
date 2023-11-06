pageextension 50120 accountant extends 9037
{
    layout
    {
        addbefore(Control36)
        {
            cuegroup(notifications)
            {
                field(PendingNotifications; Rec.Notifications)
                {
                    ApplicationArea = all;
                    StyleExpr = colorVar;
                    // Style = Standard;
                    trigger OnDrillDown()
                    var
                        noti: Record Notifications;
                    begin
                        noti.Reset();
                        noti.SetRange("User ID", UserId);
                        Page.RunModal(page::Notifications, noti);
                    end;
                }
            }
        }
        addafter("New Incoming Documents")
        {
            cuegroup("Login to HCM")
            {
                field(login; login)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        hcm: Record HCMMaster;
                    begin
                        if hcm.Get(UserId) then begin
                            Hyperlink('http://10.0.0.9:8080/Home/SubmitLoginDataFromBC?un=' + hcm.HCM_Username + '&pwd=' + hcm.passwrd);
                        end;
                    end;
                }

                field(purch; purch)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Purchase Order List");
                    end;
                }
            }
        }
        addafter("Incoming Documents")
        {
            cuegroup("Approved Documents")
            {
                Caption = 'Approved Documents';
                field("Approved Purchase Documents"; Rec."Approved Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of approved Purhcase documents in the company. The documents are filtered by today''s date.';
                }
                field(notinvoice; notinvoice)
                {
                    Caption = 'Recieved not invoiced';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        purch: Record "Purchase Header";
                    begin
                        purch.SetFilter("Amt. Rcd. Not Invoiced (LCY)", '>%1', 0);
                        if purch.FindFirst() then
                            page.RunModal(page::"Purchase Order List", purch);
                    end;
                }
                field("Approved Sales Documents"; Rec."Approved Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of approved Purhcase documents in the company. The documents are filtered by today''s date.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.CalcFields(Notifications);
        if rec.Notifications > 0 then
            colorVar := 'Unfavorable';
        if rec.Notifications = 0 then
            colorVar := 'Standard';
    end;

    trigger OnOpenPage()
    begin
        rec.CalcFields(Notifications);
        if rec.Notifications = 0 then
            Message('There are no new notifications')
        else
            Message('There are %1 new notifications', rec.Notifications);
    end;

    var
        login: Label 'Login to HCM';
        purch: Label 'Purchase Orders';
        notinvoice: Label 'Recieved not invoiced';
        colorVar: text;
}