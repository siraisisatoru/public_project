/** @type {import('tailwindcss').Config} */
const colors = require("tailwindcss/colors");

module.exports = {
    content: ["./source/**/*.{js,html}", "./themes/simple/layout/**/*.{ejs,html,js}"],
    theme: {
        extend: {
            colors: {
                "theme-color": colors.sky,
            },
            width: {
                wide: "98%",
            },
            height: {
                100: "390px",
            },
            maxWidth: {
                70: "20rem",
            },
            minWidth: {
                60: "300px",
            },
            zIndex: {
                10000: "10000",
            },
        },
    },
    plugins: [require("daisyui")],
    daisyui: {
        themes: [
            {
                mytheme: {
                    primary: "#93c5fd",

                    secondary: "#3b82f6",
                    accent: "#37CDBE",
                    neutral: "#FFFFFF",
                    "base-100": "#FFFFFF",
                    info: "#3ABFF8",
                    success: "#36D399",
                    warning: "#FBBD23",
                    error: "#F87272",
                },
            },
        ],
        logs: false,
    },
};
