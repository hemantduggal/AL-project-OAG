codeunit 50002 EFT_Post
{
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure "Vendor Ledger Entry_OnAfterCopyVendLedgerEntryFromGenJnlLine"
        (
            var VendorLedgerEntry: Record "Vendor Ledger Entry";
            GenJournalLine: Record "Gen. Journal Line"
        )
    begin
        VendorLedgerEntry."EFT/Document No." := GenJournalLine."EFT/Document No.";
        //  VendorLedgerEntry."File No." := GenJournalLine."Import File No.";
        //  VendorLedgerEntry."sub file no" := GenJournalLine."sub file no";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure "Bank Account Ledger Entry_OnAfterCopyFromGenJnlLine"
           (
               var BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
               GenJournalLine: Record "Gen. Journal Line"
           )
    begin
        BankAccountLedgerEntry."EFT/Document No." := GenJournalLine."EFT/Document No.";
        // BankAccountLedgerEntry."Import File No." := GenJournalLine."Import File No.";

    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"
 (
     var GLEntry: Record "G/L Entry";
     var GenJournalLine: Record "Gen. Journal Line"
 )
    begin
        GLEntry."EFT/Document No." := GenJournalLine."EFT/Document No.";

    END;
}