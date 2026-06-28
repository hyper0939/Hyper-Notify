const SOUNDS = {
    Info: new Audio("Sounds/Info.mp3"),
    Success: new Audio("Sounds/Success.mp3"),
    Warning: new Audio("Sounds/Warning.mp3"),
    Error: new Audio("Sounds/Error.mp3"),
}

$(document).ready(function() {
    window.addEventListener("message", function(event) {
        let data = event.data;

        if (data.action === "Show") {
            CreateNotify(data);
        }
    });
});

function PlaySound(type) {
    const sound = SOUNDS[type] ?? SOUNDS["Info"]
    sound.currentTime = 0;
    sound.volume = 0.5;
    sound.play().catch(() => {});
}

function CreateNotify(data) {
    $(".Bg").html("");
    const id = "notify_" + Date.now() + Math.floor(Math.random() * 10000)

    PlaySound(data.type);

    const notify = $(`
        <div class="NotifyFrame ${data.type}" id="${id}">
            <label class="Title">${data.title}</label>
            <label class="Message">${data.message}</label>
            <div class="ProgressbarBg">
                <div class="Progressbar"></div>
            </div>
        </div>
    `);

    $(".Bg").append(notify);

    notify.find(".Progressbar").css({
        width: "100%",
        transition: `width ${data.duration}ms linear`
    });

    setTimeout(function() {
        notify.find(".Progressbar").css("width", "0%");
    }, 20);

    setTimeout(function() {
        notify.css("animation", "SlideOutRight .45s forwards");

        setTimeout(function() {
            notify.remove();
        }, 450);
    }, data.duration);
}