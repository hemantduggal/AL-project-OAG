codeunit 50045 genjnlline
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeGenJnlPostBatchRun', '', true, true)]
    local procedure OnBeforeGenJnlPostBatchRun(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        whtpostingsetup: Record "WHT Posting Setup";
        wht: Record "WHT Entry";
        whtrec: Record "WHT Entry";
        pageL: Page "General Ledger Entries";
        lastentry: Integer;
        vend: Record "Vendor Ledger Entry";
        amt: Decimal;
        glentry: Record "G/L Entry";
        gl: Record "G/L Entry";
        entry: Integer;
        venpos: Record "Vendor Posting Group";
    begin
        // if whtpostingsetup.get(GenJnlLine."WHT Business Posting Group", GenJnlLine."WHT Product Posting Group") then;
        // // if GenJnlLine."Applies-to Doc. No." <> '' then begin
        // vend.Reset();
        // vend.SetRange("Vendor No.", GenJnlLine."Account No.");
        // vend.SetRange("Document Type", vend."Document Type"::Payment);
        // if vend.FindSet() then begin
        //     amt += vend."Amount (LCY)";
        // end;
        // if amt > 1000000 then begin
        //     whtrec.Reset();
        //     Clear(lastentry);
        //     if whtrec.FindLast() then
        //         lastentry := whtrec."Entry No.";
        //     wht.Init();
        //     wht."Entry No." := lastentry + 1;
        //     evaluate(wht."Gen. Bus. Posting Group", GenJnlLine."Gen. Bus. Posting Group");
        //     Evaluate(wht."Gen. Prod. Posting Group", GenJnlLine."Gen. Prod. Posting Group");
        //     wht."WHT Bus. Posting Group" := GenJnlLine."WHT Business Posting Group";
        //     wht."WHT Prod. Posting Group" := GenJnlLine."WHT Product Posting Group";
        //     wht."Posting Date" := GenJnlLine."Posting Date";
        //     wht."Document Date" := GenJnlLine."Posting Date";
        //     wht."Document Type" := GenJnlLine."Document Type";
        //     wht."Document No." := GenJnlLine."Document No.";
        //     wht."Currency Code" := GenJnlLine."Currency Code";
        //     if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then
        //         wht."Bill-to/Pay-to No." := GenJnlLine."Account No.";
        //     wht."User ID" := UserId;
        //     wht."Source Code" := GenJnlLine."Source Code";
        //     wht."External Document No." := GenJnlLine."External Document No.";
        //     wht."Original Document No." := GenJnlLine."Applies-to Doc. No.";
        //     wht."WHT %" := whtpostingsetup."WHT %";
        //     wht.Base := GenJnlLine.Amount;
        //     Wht.Amount := GenJnlLine."Amount" * whtpostingsetup."WHT %" / 100;
        //     wht."Base (LCY)" := GenJnlLine."Amount (LCY)";
        //     wht."Amount (LCY)" := GenJnlLine."Amount" * whtpostingsetup."WHT %" / 100;
        //     wht."WHT Revenue Type" := 'WHT';
        //     if wht.Insert() then begin
        //         Clear(entry);
        //         gl.Reset();
        //         if gl.FindLast() then
        //             entry := gl."Entry No.";
        //         venpos.get();
        //         glentry.Init();
        //         glentry."Entry No." := entry + 1;
        //         glentry."G/L Account No." := venpos."WHT VAT";
        //         evaluate(glentry."Gen. Bus. Posting Group", GenJnlLine."Gen. Bus. Posting Group");
        //         Evaluate(glentry."Gen. Prod. Posting Group", GenJnlLine."Gen. Prod. Posting Group");
        //         glentry."Posting Date" := GenJnlLine."Posting Date";
        //         glentry."Document Date" := GenJnlLine."Posting Date";
        //         glentry."Document Type" := GenJnlLine."Document Type";
        //         glentry."Document No." := GenJnlLine."Document No.";
        //         // glentry."Currency Code" := GenJnlLine."Currency Code";
        //         if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then
        //             // glentry."Bill-to/Pay-to No." := GenJnlLine."Account No.";
        //         glentry."User ID" := UserId;
        //         glentry."Source Code" := GenJnlLine."Source Code";
        //         glentry."External Document No." := GenJnlLine."External Document No.";
        //         // glentry."Original Document No." := GenJnlLine."Applies-to Doc. No.";
        //         // glentry."WHT %" := whtpostingsetup."WHT %";
        //         // glentry.Base := GenJnlLine.Amount;
        //         glentry.Amount := GenJnlLine."Amount" * whtpostingsetup."WHT %" / 100;
        //         // glentry."Base (LCY)" := GenJnlLine."Amount (LCY)";
        //         if GenJnlLine."Amount" * whtpostingsetup."WHT %" / 100 > 0 then
        //             glentry."Debit Amount" := GenJnlLine."Amount" * whtpostingsetup."WHT %" / 100
        //         else
        //             glentry."Credit Amount" := GenJnlLine."Amount" * whtpostingsetup."WHT %" / 100;
        //         // glentry."WHT Revenue Type" := 'WHT';
        //     end;
        // end;
        // end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeDeleteEvent', '', false, false)]
    // procedure RemoveGenJournalLineRestrictionsBeforeDelete(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    // var
    //     RestrictedRecord: Record "Restricted Record";
    //     RecRef: RecordRef;
    //     post: Codeunit "Gen. Jnl.-Post Batch";
    // begin
    //     RecRef.GetTable(Rec);
    //     if RecRef.IsTemporary then
    //         exit;
    //     RestrictedRecord.SetRange("Record ID", RecRef.RecordId);
    //     RestrictedRecord.LockTable(true);
    //     RestrictedRecord.DeleteAll(true);
    //     post.Run(rec);
    // end;



}