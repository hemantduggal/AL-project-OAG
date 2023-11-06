codeunit 50005 "G/L Reg.-WHT Entries"
{
    TableNo = 45;

    trigger OnRun()
    begin
        WHTEntry.SETRANGE("Entry No.", Rec."From WHT Entry No.", Rec."To WHT Entry No.");
        PAGE.Run(PAGE::"WHT Entry", WHTEntry);
    end;

    var
        WHTEntry: Record "WHT Entry";
}

