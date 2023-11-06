pageextension 50118 reqtoapprov extends "Requests to Approve"
{
    layout
    {
        addafter("Due Date")
        {
            field(startdate; Rec.startdate)
            {
                ApplicationArea = all;
            }
            field(Enddate; Rec.Enddate)
            {
                Caption = 'End date';
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify(Reject)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
                entry: Record "Approval Entry";
                entry1: Record "Approval Entry";
                wrkflow: Record "Workflow User Group Member";
                entryno: Integer;
                bnk: Record "Vendor Bank Account";
                recr: RecordRef;
                fabatch: Record "FA Reclass. Journal Batch";
            begin
                if rec."Table ID" = 288 then begin
                    recr := rec."Record ID to Approve".GetRecord();
                    recr.SetTable(bnk);
                    bnk.Status := bnk.Status::Open;
                    bnk.Modify();
                end;
                if rec."Table ID" = 5623 then begin
                    recr := rec."Record ID to Approve".GetRecord();
                    recr.SetTable(fabatch);
                    fabatch.Status := fabatch.Status::Open;
                    fabatch.Modify();
                end;
            end;
        }
        modify(Approve)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
                entry: Record "Approval Entry";
                entry1: Record "Approval Entry";
                wrkflow: Record "Workflow User Group Member";
                entryno: Integer;
                bnk: Record "Vendor Bank Account";
                recr: RecordRef;
                faset: Record "FA Setup";
                fabatch: Record "FA Reclass. Journal Batch";
            begin
                if rec."Table ID" = 5623 then begin
                    faset.get();
                    // rec.Status := rec.Status::Approved;
                    // rec."Last Date-Time Modified" := CurrentDateTime;
                    // rec."Last Modified By User ID" := UserId;
                    // rec.Modify();
                    wrkflow.SetRange("Workflow User Group Code", faset."Reclassification User Group");
                    wrkflow.SetRange("Sequence No.", rec."Sequence No." + 1);
                    if wrkflow.FindFirst() then begin
                        entry.Reset();
                        if entry.FindLast() then
                            entryno := entry."Entry No.";
                        entry.Reset();
                        entry.Init();
                        entry."Entry No." := entryno + 1;
                        entry."Table ID" := 5623;
                        entry."Document Type" := entry."Document Type"::" ";
                        entry."Document No." := Rec."Document No.";
                        entry."Sequence No." := wrkflow."Sequence No.";
                        entry."Approval Code" := 'MS-FARCAPW-01';
                        entry."Sender ID" := rec."Sender ID";
                        entry."Approver ID" := wrkflow."User Name";
                        entry.Status := entry.Status::Open;
                        entry."Date-Time Sent for Approval" := rec."Date-Time Sent for Approval";
                        entry."Record ID to Approve" := rec."Record ID to Approve";
                        entry1.Reset();
                        entry1.SetRange("Record ID to Approve", rec."Record ID to Approve");
                        entry1.SetRange(Status, entry1.Status::Open);
                        if not entry1.FindFirst() then begin
                            if entry.Insert() then
                                Message('Done');
                        end;
                    end
                    else begin
                        recr := rec."Record ID to Approve".GetRecord();
                        recr.SetTable(fabatch);
                        fabatch.Status := fabatch.Status::Approved;
                        fabatch.Modify();
                    end;
                end; //fareclass
                if rec."Table ID" = 288 then begin
                    // rec.Status := rec.Status::Approved;
                    // rec."Last Date-Time Modified" := CurrentDateTime;
                    // rec."Last Modified By User ID" := UserId;
                    // rec.Modify();
                    wrkflow.SetRange("Workflow User Group Code", 'VENDBANK');
                    wrkflow.SetRange("Sequence No.", rec."Sequence No." + 1);
                    if wrkflow.FindFirst() then begin
                        entry.Reset();
                        if entry.FindLast() then
                            entryno := entry."Entry No.";
                        entry.Reset();
                        entry.Init();
                        entry."Entry No." := entryno + 1;
                        entry."Table ID" := 288;
                        entry."Document Type" := entry."Document Type"::" ";
                        entry."Document No." := Rec."Document No.";
                        entry."Sequence No." := wrkflow."Sequence No.";
                        entry."Approval Code" := 'MS-BNKAPW-01';
                        entry."Sender ID" := rec."Sender ID";
                        entry."Approver ID" := wrkflow."User Name";
                        entry.Status := entry.Status::Open;
                        entry."Date-Time Sent for Approval" := rec."Date-Time Sent for Approval";
                        entry."Record ID to Approve" := rec."Record ID to Approve";
                        entry1.Reset();
                        entry1.SetRange("Record ID to Approve", rec."Record ID to Approve");
                        entry1.SetRange(Status, entry1.Status::Open);
                        if not entry1.FindFirst() then begin
                            if entry.Insert() then
                                Message('Done');
                        end;
                    end
                    else begin
                        recr := rec."Record ID to Approve".GetRecord();
                        recr.SetTable(bnk);
                        bnk.Status := bnk.Status::Released;
                        bnk.Modify();
                    end;
                end;
            end;
        }
        modify(Record)
        {
            trigger OnAfterAction()
            var
                ph: Record "Purchase Header";
                vend: Record Vendor;
                item: Record Item;
                recr: RecordRef;
                pay: Record 81;
                genbatch: Record "Gen. Journal Batch";
                vendbank: Record 288;
                fabatch: Record "FA Reclass. Journal Batch";
                fareclasline: Record "FA Reclass. Journal Line";
                genjnlline: Record "Gen. Journal Line";
            begin
                vend.SetRange("No.", Rec."Document No.");
                if vend.FindFirst() then
                    page.run(page::"Vendor Card", vend);
                ph.SetRange("No.", Rec."Document No.");
                if ph.FindFirst() then
                    page.run(50, ph);
                item.SetRange("No.", Rec."Document No.");
                if item.FindFirst() then
                    page.run(50, item);

                if Rec."Table ID" = 232 then begin
                    Clear(recr);
                    recr := Rec."Record ID to Approve".GetRecord();
                    recr.SetTable(genbatch);
                    genjnlline.Reset();
                    genjnlline.SetRange("Journal Template Name", genbatch."Journal Template Name");
                    genjnlline.SetRange("Journal Batch Name", genbatch.Name);
                    if genjnlline.FindFirst() then
                        page.Run(Page::"Payment Journal", genjnlline);
                end;
                if rec."Table ID" = 5623 then begin
                    Clear(recr);
                    recr := Rec."Record ID to Approve".GetRecord();
                    recr.SetTable(fabatch);
                    fareclasline.SetRange("Journal Template Name", fabatch."Journal Template Name");
                    fareclasline.SetRange("Journal Batch Name", fabatch.Name);
                    if fareclasline.FindFirst() then
                        page.Run(Page::"FA Reclass. Journal", fareclasline);
                end;
                if rec."Table ID" = 23 then begin
                    Clear(recr);
                    recr := Rec."Record ID to Approve".GetRecord();
                    recr.SetTable(vend);
                    page.Run(Page::"Vendor Card", vend);
                end;
                if rec."Table ID" = 27 then begin
                    recr := Rec."Record ID to Approve".GetRecord();
                    recr.SetTable(item);
                    page.Run(Page::"Item Card", item);
                end;
                if rec."Table ID" = 288 then begin
                    recr := rec."Record ID to Approve".GetRecord();
                    recr.SetTable(vendbank);
                    page.Run(Page::"Vendor Bank Account Card", vendbank);
                end;
            end;
        }
    }
}
