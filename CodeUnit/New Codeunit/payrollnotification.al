codeunit 50051 payrollnotification
{
    trigger OnRun()
    begin

    end;

    procedure createnotification(var Documentdate: date; var documentno: code[40])
    var
        noti: Record Notifications;
        genjoubatch: Record "Gen. Journal Batch";
        recid: RecordId;
        entryno: Integer;
        usersetup: Record "User Setup";
    begin
        usersetup.Reset();
        usersetup.SetRange(payrollnotification, true);
        if usersetup.FindSet() then
            repeat
                genjoubatch.Reset();
                genjoubatch.SetRange("Journal Template Name", 'BANK PAY');
                genjoubatch.SetRange(Name, 'PAYROLL');
                if genjoubatch.FindFirst() then
                    recid := genjoubatch.RecordId;
                noti.Reset();
                if noti.FindLast() then
                    entryno := noti.entryno;
                noti.Reset();
                noti.entryno := entryno + 1;
                noti.recordID := recid;
                noti."User ID" := usersetup."User ID";
                noti."Notification details" := 'Payroll' + Format(Documentdate) + ':' + documentno;
                noti.Notificationdatetime := CurrentDateTime;
                noti.Insert();
            until usersetup.Next() = 0;
    end;
}