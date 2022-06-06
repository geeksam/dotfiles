# k8s context (doesn't seem to work very well though)

__kube_ps1()
{
  # Get current context
	CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

	if [ -n "$CONTEXT" ]; then
		echo $CONTEXT
	fi
}
