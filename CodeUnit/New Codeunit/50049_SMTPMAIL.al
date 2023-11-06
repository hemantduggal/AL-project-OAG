codeunit 50049 smtpmail
{
    procedure sendmail(documenttype: Code[20]; docno: code[20]; sender: Code[20]; receiver: code[20]; sendemail: text[100]; recvemail: Text[100]; body: Text[200])
    var
        // SMTPMailSetup: Record 
        //  SMTPMail: Codeunit 400;]
        email: Codeunit email;
        emailmessage: Codeunit "Email Message";
        Filename: Text[100];
        FilePath: Label 'D:\PTPL\tax Invoice Path\';
        T18: Record 18;
        DrTxt: Label 'Dear Sir,';
        WeareTxt: Label 'Please find enclosed herewith your invoices as per above mentioned subject for your kind perusal. If you found any discrepancy kindly let us know within 7 days after receiving the mail.';
        ForanyTxt: Label 'For any further information, please feel free to contact our dedicated executive.';
        WithRegardTxt: Label 'With best regards!';
        SupplyTxt: Label 'OAG Alerts';
        CompInFoRec: Record 79;
        SIHRec: Record 112;
        GLSetupRec: Record 98;
        SpuMail: Text;
        SpuMail1: Text;
        SPUProjectMaster: Record 50002;
        ProjectMail: Text;
        ProjectMail1: Text;
        coln: Text;
        FinalEmail: Text;
        StringLength: Integer;
        NewFinalEmail: Text;
        CustEmail: Text;
        SalesInvoiceHeader: Record 112;
        SalespersonPurchaser: Record 13;
        ExecutiveMaster: Record 50001;
        SubjCap: Label 'Cust id %1, Invoices copies for the period of from %2 to %3';
        TextBudy: Text;
        SalespEmail: Text;
        Subname: Text;
        // body: text[200];
        Customermail: Boolean;
        Salespersonmal: Boolean;
        SalesInvoiceHeader_T: Record 112;
        NoteCap: Label 'Note : This is computer generated mail, please do-not reply on this.';
    begin

        emailmessage.AppendToBody('Hello ' + receiver);
        emailmessage.AppendToBody('<BR><BR>');
        emailmessage.Create(recvemail, documenttype + docno + 'Approval request', body, true);
        // emailmessage.AppendToBody(body);
        // emailmessage.AddAttachment();
        email.Send(emailmessage);
        // Message('sent');
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    // local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean);
    // var
    //     smtp: Codeunit smtpmail;
    //     user: Record "User Setup";
    //     noti: Record Notifications;
    // begin
    //     user.Reset();
    //     if user.get(PurchaseHeader.StoreApprover) then
    //         smtp.sendmail('Recipt : ', PurchaseHeader."No.", UserId, '', '', user."E-Mail", 'Purchase Received :' + PurchaseHeader."No.");
    //     user.Reset();
    //     if user.get(PurchaseHeader.ContractorApprover) then
    //         smtp.sendmail('Recipt : ', PurchaseHeader."No.", UserId, '', '', user."E-Mail", 'Purchase Received :' + PurchaseHeader."No.");
    //     user.Reset();
    //     if user.get(PurchaseHeader.InternalApprover) then
    //         smtp.sendmail('Recipt : ', PurchaseHeader."No.", UserId, '', '', user."E-Mail", 'Purchase Received :' + PurchaseHeader."No.");
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchRcptHeaderInsert', '', false, false)]
    local procedure OnAfterPurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; PreviewMode: Boolean);
    var
        smtp: Codeunit smtpmail;
        user: Record "User Setup";
        noti: Record Notifications;
    begin
        // user.Reset();
        // if user.get(PurchaseHeader.StoreApprover) then
        //     smtp.sendmail('Recipt : ', PurchaseHeader."No.", UserId, '', '', user."E-Mail", 'Purchase Received :' + PurchaseHeader."No.");
        // user.Reset();
        // if user.get(PurchaseHeader.ContractorApprover) then
        //     smtp.sendmail('Recipt : ', PurchaseHeader."No.", UserId, '', '', user."E-Mail", 'Purchase Received :' + PurchaseHeader."No.");
        // user.Reset();
        // if user.get(PurchaseHeader.InternalApprover) then
        //     smtp.sendmail('Recipt : ', PurchaseHeader."No.", UserId, '', '', user."E-Mail", 'Purchase Received :' + PurchaseHeader."No.");
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCreateApprovalRequestsOnAfterCreateRequests', '', false, false)]
    local procedure OnCreateApprovalRequestsOnAfterCreateRequests(RecRef: RecordRef; WorkflowStepArgument: Record "Workflow Step Argument"; var ApprovalEntryArgument: Record "Approval Entry");
    var
        smtp: Codeunit smtpmail;
        user: Record "User Setup";
        workflowusergroup: Record "Workflow User Group Member";
    begin
        // Message(WorkflowStepArgument."Workflow User Group Code");
        workflowusergroup.SetRange("Workflow User Group Code", WorkflowStepArgument."Workflow User Group Code");
        if workflowusergroup.FindFirst() then
            if workflowusergroup."Sequence No." = 1 then begin
                if user.get(workflowusergroup."User Name") then
                    smtp.sendmail('', '', UserId, user."User ID", '', user."E-Mail", 'New Notification : http://10.0.0.3:8080/BC200/Default?page=654&filter=%27Approval%20Entry%27.Status%20IS%20%271%27&company=OAG%20Dev');
            end;
    end;


    procedure sendnotification(var user_id: code[48]; var recordre: RecordId; var message: text)
    var
        smtp: Codeunit smtpmail;
        user: Record "User Setup";
        noti: Record Notifications;
    begin
        noti.Reset();
        noti."User ID" := user_id;
        noti.recordID := recordre;
        noti."Notification details" := message;
        noti.Insert();
    end;

}