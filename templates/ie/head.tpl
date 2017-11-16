<script src="/static/backend/dist/raw/editor/tinymce.min.js"></script>
<script src="/static/backend/dist/raw/editor/jquery.tinymce.min.js"></script>
<style>
    body.ready-for-edit [data-inline-edit], body.ready-for-edit [data-inline-editor] {
        background-color: rgba(0, 255, 0, 0.15);
    }
</style>

<script>
    $(function () {
        var editing = false;
        var shifted = false;

        var $editingBlock;

        function checkBody()
        {
            var $body = $('body');
            if (shifted && !editing) {
                $body.addClass('ready-for-edit');
            } else {
                $body.removeClass('ready-for-edit');
            }
        }

        function setShifted(val)
        {
            shifted = val;
            checkBody();
        }

        function setEditing(val)
        {
            editing = val;
            checkBody();
        }

        function saveEvent()
        {
            $('[data-inline-edit], [data-inline-editor]').trigger('save');
        }

        function save(data, value)
        {
            data.value = value;
            $.ajax({
                url: "{url 'ie:set'}",
                data: data,
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    if (data.success) {

                    } else if (data.error) {

                    }
                }
            })
        }

        $(document).on('keyup keydown', function (e) {
            setShifted(e.shiftKey);
            if (e.which == 83 && e.ctrlKey && e.shiftKey) {
                saveEvent();
            }
            if (editing && e.which == 27) {
                setEditing(false);
                if ($editingBlock) {
                    $editingBlock.attr('contenteditable', 'false');
                }
            }
        });

        $(document).on('click', '.ready-for-edit [data-inline-edit]', function (e) {
            e.preventDefault();
            setEditing(true);
            var $edit = $(this);
            $editingBlock = $edit;
            $edit.attr('contenteditable', 'true');
            $edit.one('save', function () {
                $edit.attr('contenteditable', 'false');
                setEditing(false);
                save($edit.data(), $edit.text());
                $editingBlock = null;
            });

            var range = document.createRange();
            var sel = window.getSelection();
            range.setStart(this, 0);
            range.collapse(true);
            sel.removeAllRanges();
            sel.addRange(range);

            return false;
        });

        $(document).on('click', '.ready-for-edit [data-inline-editor]', function (e) {
            e.preventDefault();
            setEditing(true);
            var $edit = $(this);
            var seconds = Math.round(new Date().getTime()/1000);
            var id = 'editor-' + seconds;
            $edit.attr('id', id);

            var editor = tinymce.init({
                selector: '#' + id,
                inline: true,
                plugins: [
                    'advlist autolink lists link image charmap print preview anchor',
                    'searchreplace visualblocks code fullscreen',
                    'insertdatetime media table contextmenu paste'
                ],
                toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
            });

            $edit.one('save', function () {
                setEditing(false);
                tinymce.execCommand('mceToggleEditor', false, id);
                save($edit.data(), $edit.html());
            });
            return false;
        });
    })
</script>