codeunit 50043 notificationhandler
{
    trigger OnRun()
    var
        smtp: Codeunit smtpmail;
        user: Record "User Setup";
        noti: Record Notifications;
        firstdate: Date;
    begin
        FirstDate := CALCDATE('-CM', Today);
        // message('%1....%2', firstdate, workdate());
        if firstdate = Today then begin
            user.Reset();
            user.SetRange(ChangeCurrency, true);
            if user.FindSet() then
                repeat
                    smtp.sendmail('Currency value:', ' Change', UserId, '', '', user."E-Mail", 'You need to update the currency today!');
                until user.Next() = 0;
        end;
    end;

    procedure OpenRecord(Noti: Notification)
    var
        UserID: code[40];
        User: code[40];
        DocNo: Text[200];
        requi: Text[200];
        recUser: Record User;
        requRec: Record "Requisition Header";
        reqpage: Page RequisitionCard;
    begin
        //Get the customer number data from the SetData() call.
        User := Noti.GetData('UserID');
        requi := Noti.GetData('DocNo');
        // Open the Customer Card page for the customer.
        if requRec.Get(requi) then begin
            reqpage.SetRecord(requRec);
            reqpage.Run();
        end else begin
            Error('Could not find: ' + requi);
        end;
    end;
}