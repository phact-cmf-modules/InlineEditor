# Модуль для быстрого редактирования контента

## Зависимости

Требует модуль Editor

## Установка

modules.php

```php
 'InlineEditor'
```


routes.php

```php
[
    'route' => '/ie',
    'path' => 'Modules.InlineEditor.routes',
    'namespace' => 'ie'
],
```

в head основного шаблона после подключения main.js

```smarty
{inline_editor_head:raw}
```

## Использование

Вывод данных с возможностью редактирования без wysiwig (н-р для заголовков)

```smarty
{out:raw $model 'name'}
```

Вывод данных с возможностью редактирования c wysiwig

```smarty
{out:raw $model 'content' 1}
```

Редактирование доступно после логина в режиме супер-пользователя.

После нажатия на кнопку **Shift** на странице подсветятся блоки, доступные для редактирования. 
Не отпуская кнопку **Shift** необходимо кликнуть мышкой на блок. Включится режим редактирования.
Для сохранения используем **Shift + Ctrl + S**
Для выхода из режима редактирования без сохранения жмем **Esc**