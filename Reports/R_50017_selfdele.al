report 50018 selfdeleg
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Self Delegation';
    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            trigger OnAfterGetRecord()
            var
                ApprovalEntry: Record "Approval Entry";
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            begin
                "Approval Entry".SetRange(startdate, Today);
                if "Approval Entry".FindSet() then
                    repeat
                        ApprovalsMgmt.DelegateApprovalRequests("Approval Entry");
                    until "Approval Entry".Next() = 0;
            end;
        }
    }
}