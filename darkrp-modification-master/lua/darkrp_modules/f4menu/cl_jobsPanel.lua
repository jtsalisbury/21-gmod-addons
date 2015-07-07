local colors = {
        head = Color(13, 81, 22, 255),
        back = Color(164, 18, 18, 180),
        text = Color(255, 255, 255, 255),
        btn = Color(52, 73, 94, 255),
        btn_hover = Color(44, 62, 80, 255),
        accept = Color(46, 204, 113, 255),
        accept_hover = Color(39, 174, 96, 255),
        cancel = Color(231, 76, 60, 255),
        cancel_hover = Color(192, 57, 43, 255),
        bar = Color(189, 195, 199, 255),
        barupdown = Color(127, 140, 141, 255),
        transfer = Color(230, 126, 34, 255),
        transfer_hover = Color(211, 84, 0, 255),
        transfer_disabled = Color(230, 126, 34, 150),
        accept_disabled = Color(46, 204, 113, 150),
        cancel_disabled = Color(231, 76, 60, 150),
}
 
local activeDesc = "";
local activeWeapons = {};
 
function CreateJobPanel(frame)
        local panel = vgui.Create("DPanel", frame);
        panel:SetSize(frame:GetWide() - 330, frame:GetTall() - 120);
        panel:SetPos(320, 110);
       
        /*
        local jobInfo = vgui.Create("DScrollPanel", panel);
        jobInfo:SetSize(190, panel:GetTall());
        jobInfo:SetPos(panel:GetWide() - 180, 0);
        jobInfo:GetVBar().Paint = function() draw.RoundedBox(0, 0, 0, jobInfo:GetVBar():GetWide(), jobInfo:GetVBar():GetTall(), Color(255, 255, 255, 0)) end
        jobInfo:GetVBar().btnUp.Paint = function() draw.RoundedBox(0, 0, 0, jobInfo:GetVBar().btnUp:GetWide(), jobInfo:GetVBar().btnUp:GetTall(), colors.barupdown) end
        jobInfo:GetVBar().btnDown.Paint = function() draw.RoundedBox(0, 0, 0, jobInfo:GetVBar().btnDown:GetWide(), jobInfo:GetVBar().btnDown:GetTall(), colors.barupdown) end
        jobInfo:GetVBar().btnGrip.Paint = function(w, h) draw.RoundedBox(0, 0, 0, jobInfo:GetVBar().btnGrip:GetWide(), jobInfo:GetVBar().btnGrip:GetTall(), colors.bar) end
       
        local descHead = vgui.Create("DLabel", jobInfo);
        descHead:SetPos(0, 0);
        descHead:SetText("Description");
       
        local desc = vgui.Create("DLabel", jobInfo);
        desc:SetPos(0, 15);
        desc:SetText(" ");
        desc:SetFont("f4BtnSmall");
        desc:SetSize(jobInfo:GetWide(), 1000);
        desc:SetWrap(true);
        */
       
        local jobsScroll = vgui.Create("DScrollPanel", panel);
        jobsScroll:SetSize(panel:GetWide(), panel:GetTall());
        jobsScroll:SetPos(0, 0);
        jobsScroll:GetVBar().Paint = function() draw.RoundedBox(0, 0, 0, jobsScroll:GetVBar():GetWide(), jobsScroll:GetVBar():GetTall(), Color(255, 255, 255, 0)) end
        jobsScroll:GetVBar().btnUp.Paint = function() draw.RoundedBox(0, 0, 0, jobsScroll:GetVBar().btnUp:GetWide(), jobsScroll:GetVBar().btnUp:GetTall(), colors.barupdown) end
        jobsScroll:GetVBar().btnDown.Paint = function() draw.RoundedBox(0, 0, 0, jobsScroll:GetVBar().btnDown:GetWide(), jobsScroll:GetVBar().btnDown:GetTall(), colors.barupdown) end
        jobsScroll:GetVBar().btnGrip.Paint = function(w, h) draw.RoundedBox(0, 0, 0, jobsScroll:GetVBar().btnGrip:GetWide(), jobsScroll:GetVBar().btnGrip:GetTall(), colors.bar) end
 
        for i, job in pairs(RPExtraTeams) do
                local item = vgui.Create("DButton", jobsScroll);
                item:SetSize(jobsScroll:GetWide(), 50);
                item:SetPos(0, (i-1) * 55);
                item:SetText(" ");
                local col = job.color;
                local new_col = Color(col.r, col.g, col.b, 255);
                local new_col_hov = Color(col.r + 25, col.g + 25, col.b + 25, 255);
                local ia = false;
                function item:OnCursorEntered() ia = true; end
                function item:OnCursorExited() ia = false; end
                item.Paint = function()
                        if (ia) then
                                draw.RoundedBox(0, 0, 0, item:GetWide(), item:GetTall(), new_col_hov);
                        else
                                draw.RoundedBox(0, 0, 0, item:GetWide(), item:GetTall(), new_col);
                        end
                        draw.SimpleText(job.name, "f4Btn", item:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
                end
                item.DoClick = function()
                end
               
                local join = vgui.Create("DButton", item);
                join:SetSize(100, item:GetTall());
                join:SetPos(item:GetWide() - 100, 0);
                join:SetText(" ");
                function join:OnCursorEntered() ja = true; end
                function join:OnCursorExited() ja = false; end
                local col = job.color;
                local newcol = Color(col.r + 25, col.g + 25, col.b + 25, 255);
                local newcolhov = Color(col.r + 50, col.g + 50, col.b + 50, 255);
                local ja = false;
                local text = "Join";
                if (item.vote) then text = "Vote"; end
               
                join.Paint = function()
                        if (ja) then
                                draw.RoundedBox(0, 0, 0, join:GetWide(), join:GetTall(), newcolhov);
                        else
                                draw.RoundedBox(0, 0, 0, join:GetWide(), join:GetTall(), newcol);
                        end
                        draw.SimpleText(text, "f4Btn", join:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
                end
                join.DoClick = function()
                --[[    if (job.vote) then
                                RunConsoleCommand("darkrp", "vote", job.command);
                                frame:Close();
                        else
                                RunConsoleCommand("darkrp", job.command);
                                frame:Close();
                        end ]]
               
		           if not job.team then
			        elseif job.vote or job.RequiresVote and job.RequiresVote(LocalPlayer(), job.team) then
			                RunConsoleCommand("darkrp", "vote" .. job.command)
			                frame:Close()
			        else
			                RunConsoleCommand("darkrp", job.command)
			                frame:Close()
			           end
			      end
		 
       
 
               
                if job.max ~= 0 and ((job.max % 1 == 0 and team.NumPlayers(job.team) >= job.max) or (job.max % 1 ~= 0 and (team.NumPlayers(job.team) + 1) / #player.GetAll() > job.max)) then join:SetDisabled(true); end
                if (LocalPlayer():Team() == job.team) then join:SetDisabled(true); end
               
        end
 
       
       
        return panel;
end