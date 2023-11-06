
codeunit 50035 WorkflowEventExt
{
    trigger OnRun()
    begin

    end;
    ////start Requisition workflow code

    procedure RunWorkflowOnSendRequisitionDocForApprovalCode(): code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendRequisitionDocForApproval'));
    end;

    procedure RunWorkflowOnCancelRequisitionApprovalRequestCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelRequisitionApprovalRequest'));
    end;


    procedure RunWorkflowOnCancelRequisitionMasterApprovalRequestCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelRequisitionMasterApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseRequisitionDocCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseRequisitionDoc'));
    end;
    ////end requisition workflow code

    /// start Bank Ledger Workflow code
    procedure RunWorkflowOnSendVendorBankAccDocForApprovalCode(): code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendVendorBankAccDocForApproval'));
    end;

    procedure RunWorkflowOnCancelVendorBankAccApprovalRequestCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelVendorBankAccApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseVendorBankAccDocCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseVendorBankAccDoc'));
    end;

    //////////////////
    /// start GLBudName code

    procedure RunWorkflowOnSendGLBudNameDocForApprovalCode(): code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendGLBudNameDocForApproval'));
    end;

    procedure RunWorkflowOnCancelGLBudNameApprovalRequestCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelGLBudNameApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseGLBudNameDocCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseGLBudNameDoc'));
    end;

    /// /////////////end GLBudName code

    /// end bank ledger workflow code

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; Var Variant: Variant; Var IsHandled: Boolean)
    var
        Requisitionmaster: Record "Requisition Header";
        Requisitionmaster1: Record "Requisition Header";
        VendBankAcc: Record "Vendor Bank Account";
        GLBudName: Record "G/L Budget Name";

    begin
        case RecRef.Number of
            DATABASE::"Requisition Header":
                begin
                    RecRef.SetTable(Requisitionmaster);
                    Requisitionmaster.Status := Requisitionmaster.Status::"Pending For Approval";
                    Requisitionmaster."Requested User ID" := UserId;
                    Requisitionmaster."Request Date" := Today;
                    Requisitionmaster.Modify;
                    IsHandled := true;
                end;
            Database::"Vendor Bank Account":
                begin
                    RecRef.SetTable(VendBankAcc);
                    VendBankAcc.Status := VendBankAcc.Status::"Pending For Approval";
                    VendBankAcc.Modify;
                    IsHandled := true;
                end;
            Database::"G/L Budget Name":
                begin
                    RecRef.SetTable(GLBudName);
                    GLBudName."Budget Status" := GLBudName."Budget Status"::"Approval Pending";
                    GLBudName.Modify;
                    IsHandled := true;
                end;


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionMaster: Record "Requisition Header";
        VarFilter: Text;
        EmployeeCodeVar: Code[20];
        EntryNoVarText: Text;
        EntryNoVar: Integer;
        approvalm: Codeunit "Approvals Mgmt.";
        VendBankAcc: Record "Vendor Bank Account";
        GLBudName: Record "G/L Budget Name";
    begin
        case ApprovalEntry."Table ID" of
            DATABASE::"Requisition Header":
                begin
                    // Message(Format(ApprovalEntry."Record ID to Approve"));
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");

                    EmployeeCodeVar := SelectStr(2, VarFilter);
                    EntryNoVarText := SelectStr(2, DelChr(CONVERTSTR(SelectStr(1, VarFilter), ':', ','), '=', ' '));
                    RequisitionMaster.reset();
                    //RequisitionMaster.SetRange("item Category Code", EntryNoVarText);
                    RequisitionMaster.SetRange(STATUS, RequisitionMaster.STATUS::"Pending For Approval");
                    if RequisitionMaster.FindFirst() then begin
                        RequisitionMaster.Status := RequisitionMaster.Status::Rejected;
                        RequisitionMaster."1st Approved/Rejected Date" := Today;
                        RequisitionMaster.Modify();
                    end;

                end;
            DATABASE::"Vendor Bank Account":
                begin
                    // Message(Format(ApprovalEntry."Record ID to Approve"));
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EmployeeCodeVar := SelectStr(2, VarFilter);
                    EntryNoVarText := SelectStr(2, DelChr(CONVERTSTR(SelectStr(1, VarFilter), ':', ','), '=', ' '));
                    VendBankAcc.reset();
                    VendBankAcc.SetRange(STATUS, VendBankAcc.STATUS::"Pending For Approval");
                    if VendBankAcc.FindFirst() then begin
                        VendBankAcc.Status := VendBankAcc.Status::Rejected;
                        VendBankAcc.Modify();
                    end;
                end;
            DATABASE::"G/L Budget Name":
                begin
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EmployeeCodeVar := SelectStr(2, VarFilter);
                    EntryNoVarText := SelectStr(2, DelChr(CONVERTSTR(SelectStr(1, VarFilter), ':', ','), '=', ' '));
                    GLBudName.reset();
                    GLBudName.SetRange("Budget Status", GLBudName."Budget Status"::"Approval Pending");
                    if GLBudName.FindFirst() then begin
                        GLBudName."Budget Status" := GLBudName."Budget Status"::"Revised Budget";
                        GLBudName.Modify();
                    end;

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionMaster: Record "Requisition Header";
        VarFilter: Text;
        EmployeeCodeVar: Code[20];
        EntryNoVarText: Text;
        EntryNoVar: Integer;
        approvalm: Codeunit "Approvals Mgmt.";
        AppEnRec: Record "Approval Entry";
        VendBankAcc: Record "Vendor Bank Account";
        GLBudName: Record "G/L Budget Name";
    begin
        case ApprovalEntry."Table ID" of
            DATABASE::"Requisition Header":
                begin
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EntryNoVarText := CopyStr(VarFilter, 37, StrLen(VarFilter));
                    RequisitionMaster.reset();
                    RequisitionMaster.SetRange(STATUS, RequisitionMaster.STATUS::"Pending For Approval");
                    if RequisitionMaster.FindFirst() then begin
                        RequisitionMaster.Status := RequisitionMaster.Status::Approved;
                        RequisitionMaster."1st Approved/Rejected Date" := Today;
                        RequisitionMaster.Modify();
                    end;
                end;
            DATABASE::"Vendor Bank Account":
                begin
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EntryNoVarText := CopyStr(VarFilter, 37, StrLen(VarFilter));
                    VendBankAcc.reset();
                    VendBankAcc.SetRange(STATUS, VendBankAcc.STATUS::"Pending For Approval");
                    if VendBankAcc.FindFirst() then begin
                        VendBankAcc.Status := VendBankAcc.Status::Released;
                        VendBankAcc.Modify();
                    end;
                end;
            DATABASE::"G/L Budget Name":
                begin
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EntryNoVarText := CopyStr(VarFilter, 37, StrLen(VarFilter));
                    VendBankAcc.reset();
                    GLBudName.SetRange("Budget Status", GLBudName."Budget Status"::"Approval Pending");
                    if GLBudName.FindFirst() then begin
                        GLBudName."Budget Status" := GLBudName."Budget Status"::"Final Budget";
                        GLBudName.Modify();
                    end;
                end;

        end;
    end;
    ///start code for Requisition Approval
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    Procedure AddEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRequisitionDocForApprovalCode, DATABASE::"Requisition Header", 'Approval of a Requisition Master is requested.', 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRequisitionApprovalRequestCode, Database::"Requisition Header", 'Approval of a Requisition Master is cancelled', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRequisitionMasterApprovalRequestCode, Database::"Requisition Header", 'Approval of Requisition Master is cancelled', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendVendorBankAccDocForApprovalCode(), DATABASE::"Vendor Bank Account", 'Approval of a Vendor Bank Account is requested.', 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVendorBankAccApprovalRequestCode(), Database::"Vendor Bank Account", 'Approval of a Vendor Bank Account is cancelled', 0, false);
        //////////////
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendGLBudNameDocForApprovalCode(), DATABASE::"G/L Budget Name", 'Approval of a GLBudName is requested.', 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelGLBudNameApprovalRequestCode(), Database::"G/L Budget Name", 'Approval of a GLBudName is cancelled', 0, false);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelRequisitionForApproval', '', false, false)]
    Procedure RunWorkflowOnCancelRequisitionApprovalRequest(var RequisitionMaster: Record "Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRequisitionApprovalRequestCode, RequisitionMaster);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelRequisitionMasterForApproval', '', false, false)]
    Procedure RunWorkflowOnCancelRequisitionMasterApprovalRequest(var RequisitionMaster: Record "Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRequisitionMasterApprovalRequestCode, RequisitionMaster);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendRequisitionForApproval', '', false, false)]
    Procedure RunWorkflowOnSendRequisitionForApproval(var Requisitionmaster: Record "Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRequisitionDocForApprovalCode, Requisitionmaster);
    end;
    ////End code for Requisition Approval

    ///start code for Bank Account Approval
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelVendorBankAccForApproval', '', false, false)]
    Procedure RunWorkflowOnCancelVendorBankAccApprovalRequest(var VendBankAcc: Record "Vendor Bank Account")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelVendorBankAccApprovalRequestCode, VendBankAcc);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendVendorBankAccForApproval', '', false, false)]
    Procedure RunWorkflowOnSendVendorBankAccForApproval(var VendBankAcc: Record "Vendor Bank Account")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendVendorBankAccDocForApprovalCode, VendBankAcc);
    end;

    ///end code for Bank Account Approval
    ////////////////////////

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelGLBudNameForApproval', '', false, false)]
    Procedure RunWorkflowOnCancelGLBudNameApprovalRequest(var GLBudName: Record "G/L Budget Name")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGLBudNameApprovalRequestCode, GLBudName);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendGLBudNameForApproval', '', false, false)]
    Procedure RunWorkflowOnSendGLBudNameForApproval(var GLBudName: Record "G/L Budget Name")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGLBudNameDocForApprovalCode, GLBudName);
    end;

    /// ///////////////////


    // Start Pru Sh20042022
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]

    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    var

    begin
        if PageID = 0 then;
        PageID := GetConditionalCardPageID(RecordRef);
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of
            Database::"Requisition Header":
                exit(Page::RequisitionCard);
            Database::"Vendor Bank Account":
                exit(Page::"Vendor Bank Account Card");
            Database::"G/L Budget Name":
                exit(Page::"G/L Budget Standard")

        end;
    end;
    // End Pru Sh20042022
    var
        myInt: Integer;

        worlfloeeven: Codeunit 1520;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        pageMgt: Codeunit "Page Management";
        workflowevent: Record 1509;

}

