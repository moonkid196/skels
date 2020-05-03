# Defined in /var/folders/92/qvvw45b973d1bq69v63gxlsc0000gn/T//fish.99qCw8/gcloud_init.fish @ line 2
function gcloud_init
	set -l venv ~/dev/venvs/gcloud
    set -l gcloud_setup ~/dev/pkgs/google-cloud-sdk/path.fish.inc

    if test -n "$VIRTUAL_ENV"
        echo "existing virtualenv already active: $VIRTUAL_ENV" >&2
        return
    end

    source $venv/bin/activate.fish
    source $gcloud_setup
end
