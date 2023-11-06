codeunit 50050 CaptureGLEntryInconsistencies
{
    SingleInstance = true;

    VAR
        TempGLEntry: Record "G/L Entry" temporary;
        StoreToTemp: Boolean;

    trigger OnRun()
    BEGIN
        IF NOT StoreToTemp THEN BEGIN
            StoreToTemp := TRUE;
        END ELSE
            PAGE.RUNMODAL(0, TempGLEntry);
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertGlobalGLEntry', '', true, true)]
    PROCEDURE InsertGL(var GLEntry: Record "G/L Entry");
    BEGIN
        IF StoreToTemp THEN BEGIN
            TempGLEntry := GLEntry;
            IF NOT TempGLEntry.INSERT THEN BEGIN
                TempGLEntry.DELETEALL;
                TempGLEntry.INSERT;
            END;
        END;
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnBeforeReleaseDocument', '', false, false)]
    local procedure OnBeforeReleaseDocument(var Variant: Variant);
    var
        RecRef: RecordRef;
        vend: Record Vendor;
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean);
    var
        ven: Record Vendor;
        vend1: Record Vendor;
    begin
        if RecRef.Number() = 23 then begin
            RecRef.SetTable(ven);
            vend1.get(ven."No.");
            vend1.status := vend1.status::Approved;
            vend1.Modify();
            Handled := true;
        end;
    end;

}