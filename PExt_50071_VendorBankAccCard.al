pageextension 50071 VendBankAccExt extends "Vendor Bank Account Card"
{
    layout
    {
        modify("Address 2")
        {
            Caption = 'Branch Name';
        }
        addafter("Transit No.")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        //area(creation)
        addfirst(Processing)
        {

            group(Approval)
            {
                action("Send For Approval")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Caption = 'Send For Approval';
                    Image = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                        entry: Record "Approval Entry";
                        entry1: Record "Approval Entry";
                        wrkflow: Record "Workflow User Group Member";
                        entryno: Integer;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        wrkflow.SetRange("Workflow User Group Code", 'VENDBANK');
                        wrkflow.SetRange("Sequence No.", 1);
                        if wrkflow.FindFirst() then begin
                            entry.Reset();
                            if entry.FindLast() then
                                entryno := entry."Entry No.";
                            entry.Reset();
                            entry.Init();
                            entry."Entry No." := entryno + 1;
                            entry."Table ID" := 288;
                            entry."Document Type" := entry."Document Type"::" ";
                            entry."Document No." := Rec.Code;
                            entry."Sequence No." := wrkflow."Sequence No.";
                            entry."Approval Code" := 'MS-BNKAPW-01';
                            entry."Sender ID" := UserId;
                            entry."Approver ID" := wrkflow."User Name";
                            entry.Status := entry.Status::Open;
                            entry."Date-Time Sent for Approval" := CurrentDateTime;
                            entry."Record ID to Approve" := rec.RecordId;
                            entry1.Reset();
                            entry1.SetRange("Record ID to Approve", rec.RecordId);
                            entry1.SetRange(Status, entry1.Status::Open);
                            if not entry1.FindFirst() then begin
                                if entry.Insert() then begin
                                    rec.Status := Rec.Status::"Pending For Approval";
                                    Rec.Modify();
                                end;
                                Message('Sent');
                            end
                            else begin
                                rec.Status := Rec.Status::"Pending For Approval";
                                rec.Modify();
                            end;
                        end;
                        // IF ApprovalsMgmt.CheckVendorBankAccApprovalsWorkflowEnabled(Rec) THEN
                        //     ApprovalsMgmt.OnSendVendorBankAccForApproval(Rec);

                    end;
                }
                action("Cancel Approval")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Caption = 'Cancel Approval';
                    Image = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        entry: Record "Approval Entry";
                        entry1: Record "Approval Entry";
                        wrkflow: Record "Workflow User Group Member";
                        entryno: Integer;
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                    begin
                        entry.Reset();
                        entry.SetRange(Status, entry.Status::Open);
                        entry.SetRange("Record ID to Approve", rec.RecordId);
                        if entry.FindFirst() then begin
                            entry.Status := entry.Status::Canceled;
                            entry.Modify();
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end;
                        // ApprovalsMgmt.OnCancelVendorBankAccForApproval(Rec);
                    end;
                }
            }
        }
    }
}