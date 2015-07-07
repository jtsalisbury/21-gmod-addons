if (SERVER) then return; end

include("sh_bank.lua");

hook.Add("PostDrawOpaqueRenderables", "ShowBankAmt", function()
	local bankAmt = GetGlobalFloat("bank_money");
	cam.Start3D2D(Vector(-1050.909546, 955.352661, 10.483765), Angle(360, 0.072380, 90), 1)
		draw.WordBox( 1, 0, 0, " Vault: $"..string.Comma(bankAmt).." ", "DermaLarge", Color(0, 0, 0, 255), Color(255, 255, 255, 255) )
    cam.End3D2D()
end)