codeunit 50042 "Workflow Response HandlingExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; Var Handled: Boolean)
    var
        BudgetMaster: Record "Requisition Header";
        VendBankAcc: Record "Vendor Bank Account";
        GLBudName: Record "G/L Budget Name";
        ItemJournal: Record "Item Journal Line";
    begin
        case RecRef.Number of
            DATABASE::"Requisition Header":
                begin
                    RecRef.SetTable(BudgetMaster);
                    BudgetMaster.Status := BudgetMaster.Status::Open;
                    BudgetMaster.Modify();
                    Handled := true;
                end;
            DATABASE::"Vendor Bank Account":
                begin
                    RecRef.SetTable(VendBankAcc);
                    VendBankAcc.Status := VendBankAcc.Status::Open;
                    VendBankAcc.Modify();
                    Handled := true;
                end;
            DATABASE::"G/L Budget Name":
                begin
                    RecRef.SetTable(GLBudName);
                    GLBudName."Budget Status" := GLBudName."Budget Status"::"Initial Budget";
                    GLBudName.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BudgetMaster: Record "Requisition Header";
        BaseCalenderChange_Rec: Record "Base Calendar Change";
        VendBankAcc: Record "Vendor Bank Account";
        GLBudName: Record "G/L Budget Name";
    begin
        case RecRef.Number of
            DATABASE::"Requisition Header":
                begin
                    RecRef.SetTable(BudgetMaster);
                    BudgetMaster.Status := BudgetMaster.Status::Approved;
                    BudgetMaster.Modify();
                    Handled := true;
                end;
            DATABASE::"Vendor Bank Account":
                begin
                    RecRef.SetTable(VendBankAcc);
                    VendBankAcc.Status := VendBankAcc.Status::Released;
                    VendBankAcc.Modify();
                    Handled := true;
                end;
            DATABASE::"G/L Budget Name":
                begin
                    RecRef.SetTable(GLBudName);
                    GLBudName."Budget Status" := GLBudName."Budget Status"::"Final Budget";
                    GLBudName.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling"; //1521;
        WorkflowEventHandlingCust: Codeunit 50035; // 50112;
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendRequisitionDocForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendVendorBankAccDocForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendGLBudNameDocForApprovalCode);

                end;
            WorkflowResponseHandling.CreateApprovalRequestsCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode(), WorkflowEventHandlingCust.RunWorkflowOnSendRequisitionDocForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnSendVendorBankAccDocForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnSendGLBudNameDocForApprovalCode);

                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendRequisitionDocForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendVendorBankAccDocForApprovalCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendGLBudNameDocForApprovalCode);

                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnCancelRequisitionMasterApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnCancelVendorBankAccApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnCancelGLBudNameApprovalRequestCode);

                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingCust.RunWorkflowOnCancelRequisitionApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingCust.RunWorkflowOnCancelVendorBankAccApprovalRequestCode);
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingCust.RunWorkflowOnCancelGLBudNameApprovalRequestCode);

                END;

        end;
    end;






    var
        myInt: Integer;
}
