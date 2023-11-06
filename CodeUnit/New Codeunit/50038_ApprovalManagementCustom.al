codeunit 50038 "Approval Management Custom"
{
    trigger OnRun()
    begin

    end;

    //start requisition code 
    [IntegrationEvent(false, false)]
    procedure OnSendRequisitionForApproval(Var Requisitionmaster: Record "Requisition Header")
    begin

    end;

    procedure OnSendPurchRequisitionForApproval(Var Requisitionmaster: Record "purchase Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRequisitionForApproval(Var RequisitionMaster: Record "Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRequisitionMasterForApproval(Var RequisitionMaster: Record "Requisition Header")
    begin
    end;

    procedure OnCancelPurchRequisitionMasterForApproval(Var RequisitionMaster: Record "purchase Requisition Header")
    begin
    end;

    procedure CheckRequisitionApprovalsWorkflowEnabled(var RequisitionMaster: Record "Requisition Header"): Boolean
    begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(RequisitionMaster, Subscriber_CU.RunWorkflowOnSendRequisitionDocForApprovalCode) then
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;
    ////end requsition code
    procedure CheckpurchRequisitionApprovalsWorkflowEnabled(var RequisitionMaster: Record "purchase Requisition Header"): Boolean
    begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(RequisitionMaster, Subscriber_CU.RunWorkflowOnSendRequisitionDocForApprovalCode) then
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;

    //start Bank Acc  code 

    [IntegrationEvent(false, false)]
    procedure OnSendVendorBankAccForApproval(Var VendBankAcc: Record "Vendor Bank Account")
    begin
    end;



    [IntegrationEvent(false, false)]
    procedure OnCancelVendorBankAccForApproval(Var VendBankAcc: Record "Vendor Bank Account")
    begin
    end;

    procedure CheckVendorBankAccApprovalsWorkflowEnabled(Var VendBankAcc: Record "Vendor Bank Account"): Boolean
    begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(VendBankAcc, Subscriber_CU.RunWorkflowOnSendVendorBankAccDocForApprovalCode) then
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;

    ////end Bank Acc code



    ///////////////

    [IntegrationEvent(false, false)]
    procedure OnSendGLBudNameForApproval(Var GLBudName: Record "G/L Budget Name")
    begin
    end;



    [IntegrationEvent(false, false)]
    procedure OnCancelGLBudNameForApproval(Var GLBudName: Record "G/L Budget Name")
    begin
    end;

    procedure CheckGLBudNameApprovalsWorkflowEnabled(Var GLBudName: Record "G/L Budget Name"): Boolean
    begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(GLBudName, Subscriber_CU.RunWorkflowOnSendGLBudNameDocForApprovalCode) then
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;




    /// //////////



    var
        myInt: Integer;
        NoWorkflowEnabledErr: TextConst ENU = 'This record is not supported by related approval workflow.';
        WorkflowManagement: Codeunit "Workflow Management";
        Subscriber_CU: Codeunit 50035;
        work: Codeunit "Record Restriction Mgt.";

}
