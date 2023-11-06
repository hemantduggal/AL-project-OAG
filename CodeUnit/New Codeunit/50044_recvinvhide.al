codeunit 50044 recvinovoice
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeValidateVATProdPostingGroup', '', false, false)]
    local procedure OnBeforeValidateVATProdPostingGroup(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean);
    begin
        IsHandled := true;
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforePrePostApprovalCheckPurch', '', true, true)]
    // local procedure "Approvals Mgmt._OnBeforePrePostApprovalCheckPurch"
    // (
    //     var PurchaseHeader: Record "Purchase Header";
    //     var Result: Boolean;
    //     var IsHandled: Boolean
    // )
    // begin
    //     IsHandled := true;
    //     Result := true;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean)
    begin
        HideDialog := true;
        NewConfirmPost(PurchaseHeader);
    end;

    local procedure NewConfirmPost(var purchaseorder: Record "Purchase Header"): Boolean
    var
        Selection: Integer;
        ConfirmManagement: Codeunit "Confirm Management";
        ShipInvoiceQst: Label '&Recieve,&Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ReceiveInvoiceQst: Label '&Receive,&Invoice';
        NothingToPostErr: Label 'There is nothing to post.';
        usersetup: Record "User Setup";
    begin
        case purchaseorder."Document Type" of
            purchaseorder."Document Type"::Order:
                begin
                    Selection := StrMenu(ReceiveInvoiceQst, 1);
                    if UserSetup.get(UserId) then
                        if usersetup.storeuser = true then
                            purchaseorder.Receive := Selection in [1];
                    if UserSetup.get(UserId) then
                        if usersetup.accountuser = true then
                            purchaseorder.Invoice := Selection in [2];
                    if Selection = 0 then
                        exit(false);
                end;
            purchaseorder."Document Type"::"Return Order":
                begin
                    Selection := StrMenu(ReceiveInvoiceQst, 1);
                    if Selection = 0 then
                        exit(false);
                    purchaseorder.Receive := Selection in [1];
                    purchaseorder.Invoice := Selection in [2];
                end
            else
                if not ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(PostConfirmQst, LowerCase(Format(purchaseorder."Document Type"))), true)
                then
                    exit(false);
        end;
        purchaseorder."Print Posted Documents" := false;
        exit(true);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Record Restriction Mgt.", 'OnBeforeGenJournalLineCheckGenJournalLinePostRestrictions', '', false, false)]
    // local procedure OnBeforeGenJournalLineCheckGenJournalLinePostRestrictions(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean);
    // var
    //     wrk: Record Workflow;
    // begin
    //     IsHandled := true;
    // end;

}