codeunit 50000 RequistionPost
{
    procedure PostRequistion(ReqH: Record "Requisition Header"; ReqL: Record Requisition_Line)
    var
        ItemJournalLine: Record 83;
        C22: Codeunit 22;
        ItemRec: Record Item;
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine."Journal Batch Name" := 'REQ. ISSUE';
        ItemJournalLine."Line No." := GetLineNoIssue('TRANSFER', 'REQ. ISSUE');
        ItemJournalLine."Document No." := ReqH."Requisition Slip No.";
        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
        ItemJournalLine.VALIDATE("Item No.", ReqL."No.");
        //ItemJournalLine.VALIDATE("Variant Code",IssueLine."Variant Code");
        ItemJournalLine."Posting Date" := ReqH."Request Date";
        ItemJournalLine.VALIDATE("Location Code", Reql."Store Location");
        ItemJournalLine.VALIDATE(Quantity, ReqL."Issued Quantity");
        ItemJournalLine.VALIDATE("Unit of Measure Code", ReqL."Unit of Measure Code");

        ItemJournalLine.VALIDATE("New Location Code", ReqH."Location Code");
        //ItemJournalLine.Insert();
        C22.RunWithCheck(ItemJournalLine);

        ReqL."Post Issue Qty" += ReqL."Issued Quantity";
        //   ReqL."Issued Quantity" := 0;
        ReqL.Modify();
        //Message('')




    end;

    procedure PostPurchRequistion(ReqH: Record "purchase Requisition Header"; ReqL: Record "Purchase Requisition Line")
    var
        ItemJournalLine: Record 83;
        C22: Codeunit 22;
        ItemRec: Record Item;
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine."Journal Batch Name" := 'REQ. ISSUE';
        ItemJournalLine."Line No." := GetLineNoIssue('TRANSFER', 'REQ. ISSUE');
        ItemJournalLine."Document No." := ReqH."Requisition Slip No.";
        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
        ItemJournalLine.VALIDATE("Item No.", ReqL."No.");
        //ItemJournalLine.VALIDATE("Variant Code",IssueLine."Variant Code");
        ItemJournalLine."Posting Date" := ReqH."Request Date";
        ItemJournalLine.VALIDATE("Location Code", Reql."Store Location");
        ItemJournalLine.VALIDATE(Quantity, ReqL."Issued Quantity");
        ItemJournalLine.VALIDATE("Unit of Measure Code", ReqL."Unit of Measure Code");

        ItemJournalLine.VALIDATE("New Location Code", ReqH."Location Code");
        //ItemJournalLine.Insert();
        C22.RunWithCheck(ItemJournalLine);

        ReqL."Post Issue Qty" += ReqL."Issued Quantity";
        //   ReqL."Issued Quantity" := 0;
        ReqL.Modify();
        //Message('')




    end;

    procedure GetLineNoIssue(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

}