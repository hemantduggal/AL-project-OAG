tableextension 50056 loc extends Location
{
    fields
    {
        field(50000; "Store location"; Boolean)
        {
            Caption = 'Store Location';
            DataClassification = ToBeClassified;
            Description = 'Lomesh_0.1';
            trigger OnValidate()
            var
                loc: Record Location;
            begin
                loc.Reset();
                loc.SetFilter(Code, '<>%1', Rec.Code);
                if loc.FindSet() then
                    repeat
                        if loc."Store location" = true then
                            Error('Only one store location allowed');
                    until loc.Next() = 0;
            end;
        }
    }
}