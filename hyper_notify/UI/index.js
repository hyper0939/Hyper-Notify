const SOUNDS = {
    Info: new Audio("Sounds/Info.mp3"),
    Success: new Audio("Sounds/Success.mp3"),
    Warning: new Audio("Sounds/Warning.mp3"),
    Error: new Audio("Sounds/Error.mp3"),
}

$(document).ready(function() {
    $(".Bg").empty();
    $(".AnnounceBg").empty();

    window.addEventListener("message", function(event) {
        let data = event.data;

        if (data.action === "Show") {
            CreateNotify(data);
        } else if (data.action === "Announce") {
            CreateAnnounce(data);
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

    requestAnimationFrame(function() {
        requestAnimationFrame(function() {
            notify.find(".Progressbar").css("width", "0%");
        });
    });

    setTimeout(function() {
        notify.css("animation", "SlideOutRight .45s forwards");

        setTimeout(function() {
            notify.remove();
        }, 450);
    }, data.duration);
}

function CreateAnnounce(data) {
    const id = "announce_" + Date.now() + Math.floor(Math.random() * 10000)

    PlaySound(data.sound ?? "Warning");

    const announce = $(`
        <div class="AnnounceFrame" id="${id}">
            <label class="AnnounceTitle">${data.title}</label>
            <label class="AnnounceMessage">${data.message}</label>
            <div class="AnnounceProgressbarBg">
                <div class="AnnounceProgressbar"></div>
            </div>
        </div>
    `);

    $(".AnnounceBg").append(announce);

    announce.find(".AnnounceProgressbar").css({
        width: "100%",
        transition: `width ${data.duration}ms linear`
    });

    requestAnimationFrame(function() {
        requestAnimationFrame(function() {
            announce.find("AnnounceProgressbar").css("width", "0%");
        });
    });

    setTimeout(function() {
        announce.css("animation", "SlideOutTop .45s forwards");

        setTimeout(function() {
            announce.remove();
        }, 450);
    }, data.duration);
}