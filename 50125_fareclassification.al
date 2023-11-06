pageextension 50126 fareclassification extends 5636
{
    layout
    {

    }
    actions
    {
        addafter(Reclassify)
        {
            group("Approvals")
            {
                action("Send For Approval")
                {
                    ApplicationArea = Suite;
                    Image = SendApprovalRequest;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                        entry: Record "Approval Entry";
                        entry1: Record "Approval Entry";
                        wrkflow: Record "Workflow User Group Member";
                        entryno: Integer;
                        fasetup: Record "FA Setup";
                        fareclass: Record "FA Reclass. Journal Batch";
                    begin
                        fasetup.Get();
                        fareclass.get(rec."Journal Template Name", rec."Journal Batch Name");
                        wrkflow.SetRange("Workflow User Group Code", fasetup."Reclassification User Group");
                        wrkflow.SetRange("Sequence No.", 1);
                        if wrkflow.FindFirst() then begin
                            entry.Reset();
                            if entry.FindLast() then
                                entryno := entry."Entry No.";
                            entry.Reset();
                            entry.Init();
                            entry."Entry No." := entryno + 1;
                            entry."Table ID" := fareclass.RecordId.TableNo;
                            entry."Document Type" := entry."Document Type"::" ";
                            entry."Document No." := fareclass.Name;
                            entry."Sequence No." := wrkflow."Sequence No.";
                            entry."Approval Code" := 'MS-FARCAPW-01';
                            entry."Sender ID" := UserId;
                            entry."Approver ID" := wrkflow."User Name";
                            entry.Status := entry.Status::Open;
                            entry."Date-Time Sent for Approval" := CurrentDateTime;
                            entry."Record ID to Approve" := fareclass.RecordId;
                            entry1.Reset();
                            entry1.SetRange("Record ID to Approve", fareclass.RecordId);
                            entry1.SetRange(Status, entry1.Status::Open);
                            if not entry1.FindFirst() then begin
                                if entry.Insert() then begin
                                    fareclass.Status := fareclass.Status::"Pending For Approval";
                                    fareclass.Modify();
                                end;
                                Message('Sent');
                                CurrPage.Editable(false);
                            end
                            else begin
                                fareclass.Status := fareclass.Status::"Pending For Approval";
                                fareclass.Modify();
                            end;
                        end;

                    end;
                }
                action("Cancel Approval")
                {
                    ApplicationArea = all;
                    Image = CancelApprovalRequest;
                    trigger OnAction()
                    var
                        entry1: Record "Approval Entry";
                        fareclass: Record "FA Reclass. Journal Batch";
                    begin
                        fareclass.get(rec."Journal Template Name", rec."Journal Batch Name");
                        entry1.Reset();
                        entry1.SetRange("Record ID to Approve", fareclass.RecordId);
                        entry1.SetRange(Status, entry1.Status::Open);
                        if entry1.FindFirst() then begin
                            entry1.Status := entry1.Status::Canceled;
                            entry1.Modify();
                            CurrPage.Editable(true);
                        end;
                        if fareclass.Status <> fareclass.Status::Open then begin
                            fareclass.Status := fareclass.Status::Open;
                            fareclass.Modify();
                        end;

                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        entry1: Record "Approval Entry";
        fareclass: Record "FA Reclass. Journal Batch";
    begin
        if fareclass.get(rec."Journal Template Name", rec."Journal Batch Name") then
            if fareclass.Status <> fareclass.Status::Open then
                Error('Status should be Open');
    end;

    trigger OnModifyRecord(): Boolean
    var
        entry1: Record "Approval Entry";
        fareclass: Record "FA Reclass. Journal Batch";
    begin
        if fareclass.get(rec."Journal Template Name", rec."Journal Batch Name") then
            if fareclass.Status <> fareclass.Status::Open then
                Error('Status should be Open');
    end;

    trigger OnDeleteRecord(): Boolean
    var
        entry1: Record "Approval Entry";
        fareclass: Record "FA Reclass. Journal Batch";
    begin
        if fareclass.get(rec."Journal Template Name", rec."Journal Batch Name") then
            if fareclass.Status <> fareclass.Status::Open then
                Error('Status should be Open');
    end;
}