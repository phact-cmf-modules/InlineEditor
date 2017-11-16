<?php
/**
 *
 *
 * All rights reserved.
 *
 * @author Okulov Anton
 * @email qantus@mail.ru
 * @version 1.0
 * @company HashStudio
 * @site http://hashstudio.ru
 * @date 02/06/17 08:05
 */
namespace Modules\InlineEditor\TemplateLibraries;

use Phact\Main\Phact;
use Phact\Template\Renderer;
use Phact\Template\TemplateLibrary;

class OutputLibrary extends TemplateLibrary
{
    use Renderer;
    
    protected static $_allowEdit;
    
    public static function getIsAllow()
    {
        if (is_null(self::$_allowEdit)) {
            self::$_allowEdit = Phact::app()->user->is_superuser;
        }
        return self::$_allowEdit;
    }
    /**
     * @name inline_editor_head
     * @kind function
     */
    public static function get()
    {
        if (self::getIsAllow()) {
            return static::renderTemplate('ie/head.tpl', [

            ]);
        } else {
            return '';
        }
        
    }

    /**
     * @name out
     * @kind function
     */
    public static function out($params)
    {
        $model = isset($params['model']) ? $params['model'] : null;
        if (!$model) {
            $model = isset($params[0]) ? $params[0] : null;
        }

        $attribute = isset($params['attribute']) ? $params['attribute'] : null;
        if (!$attribute) {
            $attribute = isset($params[1]) ? $params[1] : [];
        }

        $editor = isset($params['editor']) ? $params['editor'] : null;
        if (is_null($editor)) {
            $editor = isset($params[2]) ? $params[2] : false;
        }

        $value = $model->{$attribute};
        if (self::getIsAllow()) {
            return static::renderTemplate('ie/block.tpl', [
                'model' => $model,
                'attribute' => $attribute,
                'value' => $value,
                'editor' => $editor
            ]);
        } else {
            return $value;
        }
    }
}