Force to use markdown to prevent pypi issue

Recently the pypi team have reintroduce some deactivated tests
on package deployment and especially tests concerning long_description
syntaxe.

If projects don't specify that they use the markdown format the
package deployment will fail if something went wrong in the markdown format.

By example if a project use inline literal this can be an issue due to
the fact that if `long_description_content_type` is missing [1]. The 
default format will be `text/x-rst` where code block is different from
markdown.

These changes force to use the markdown format to avoid this kind of issue
on project who use `README` at markdown format.

[1] http://lists.openstack.org/pipermail/openstack-discuss/2019-July/007459.html

For more details:
https://github.com/pypa/warehouse/issues/5890#issuecomment-494868157
