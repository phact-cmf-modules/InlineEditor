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
 * @date 02/06/17 08:04
 */
namespace Modules\InlineEditor\Controllers;

use Phact\Controller\Controller;
use Phact\Main\Phact;

class InlineEditorController extends Controller
{
    public function set()
    {
        if (Phact::app()->user->is_superuser && $this->request->getIsPost()) {
            $class = isset($_POST['class']) ? $_POST['class'] : null;
            $id = isset($_POST['id']) ? $_POST['id'] : null;
            $attribute = isset($_POST['attribute']) ? $_POST['attribute'] : null;
            $value = isset($_POST['value']) ? $_POST['value'] : null;

            if ($class && $id && $attribute) {
                $model = $class::objects()->filter(['id' => $id])->limit(1)->get();
                if ($model) {
                    $model->{$attribute} = $value;
                    if ($model->save()) {
                        $this->jsonResponse([
                            'success' => 1
                        ]);
                        Phact::app()->end();
                    }
                }
            }
            $this->jsonResponse([
                'error' => 1
            ]);
            Phact::app()->end();
        }
        $this->error(404);
    }
}