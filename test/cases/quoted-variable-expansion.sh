echo "Downloading $ARTIFACT from ${REPO} run ${RUN_ID}"
echo "Packages: ${PACKAGES[@]} and ${PACKAGES[0]}"
echo "Escaped \$ARTIFACT stays text"
echo 'Single-quoted $ARTIFACT stays text'
echo "after quote" && echo done
