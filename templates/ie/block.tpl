{if $editor}
    <div data-inline-editor data-raw="1" data-class="{$model->className()}" data-id="{$model->id}" data-attribute="{$attribute}">
        {raw $value}
    </div>
{else}
    <span data-inline-edit data-raw="0" data-class="{$model->className()}" data-id="{$model->id}" data-attribute="{$attribute}">
        {raw $value}
    </span>
{/if}