return {
    {
        "epwalsh/pomo.nvim",
        version = "*",  -- Recommended, use latest release instead of latest commit
        cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
        dependencies = {"telescope.nvim"},
        opts = {
        },
        config = function()
            require("pomo").setup({
            --from epwalsh
            update_interval=5000,
            notifiers = {
                { name = "Default", opts = { sticky = false } },
              --  { name = "System" }, -- rings the system bell... a bit ann
            },
            timers = {
                Stretching = {
                    { name = "Default" },
                    { name = "System" },
                },
                Break = {
                    { name = "Default" },
                    { name = "System" },
                },
                ["Short Break"] = {
                    { name = "Default", opts = { sticky = true } },
                    { name = "System" },
                },
                ["Long Break"] = {
                    { name = "Default", opts = { sticky = true } },
                    { name = "System" },
                },
            },
            sessions = {
                pomodoroPod = {
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                },
                pomodoroHour = {
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                },
                classicPomodoro = {
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Long Break", duration = "30m" },
                },
            },
            })
        end,
    },
}
